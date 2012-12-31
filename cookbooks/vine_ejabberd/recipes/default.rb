#
# Cookbook Name:: vine_ejabberd
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

env_data = data_bag_item("dev_data", "dev_data")

# Make sure our directories exist
["#{node['source_dir']}"
].each do |dir|
  directory dir do
    mode 0644
    owner env_data["server"]["user"]
    group env_data["server"]["user"]
    recursive true
    action :create
  end
end

# Downdload and install ejabberd, then make sure it runs
git "#{node['vine_ejabberd']['ejabberd_repo_dir']}" do
  repository "https://github.com/lehrblogger/ejabberd.git"
  # use this HTTP URL, since the SSH URL requires a deploy key
  branch "2.1.x-stanza-restrictions"
  destination "#{node['vine_ejabberd']['ejabberd_repo_dir']}"
  action :sync
end
package "libexpat1-dev"
execute "./configure, make, and install ejabberd" do
  command "./configure && make && sudo make install"
  cwd "#{node['vine_ejabberd']['ejabberd_repo_dir']}/src"
  action :run
end
execute "start ejabberd" do
  command "sudo ejabberdctl start"
  action :run
end

# Download and install the modules, and restart ejabberd
git "#{node['vine_ejabberd']['modules_repo_dir']}" do
  repository "https://github.com/lehrblogger/ejabberd-modules.git"
  branch "master"
  destination "#{node['vine_ejabberd']['modules_repo_dir']}"
  action :sync
end
["mod_admin_extra",
 "ejabberd_xmlrpc",
].each do |module_name|
  execute "build #{module_name} module for ejabberd" do
    command "./build.sh"
    cwd "#{node['vine_ejabberd']['modules_repo_dir']}/#{module_name}/trunk"
    action :run
  end
  execute "install #{module_name} module for ejabberd" do
    command "cp ebin/#{module_name}.beam #{node['vine_ejabberd']['ejabberd_dir']}/ebin/"
    cwd "#{node['vine_ejabberd']['modules_repo_dir']}/#{module_name}/trunk"
    action :run
  end
end
remote_file "/tmp/xmlrpc-1.13-ipr2.tgz" do
  source "http://ejabberd.jabber.ru/files/contributions/xmlrpc-1.13-ipr2.tgz"
  notifies :run, "bash[install_xmlrpc_erlang]", :immediately
end
bash "install_xmlrpc_erlang" do
  cwd "/tmp"
  code <<-EOH
    tar -xzvf xmlrpc-1.13-ipr2.tgz
    (cd xmlrpc-1.13/src && make && cp ../ebin/*.beam #{node['vine_ejabberd']['ejabberd_dir']}/ebin/)
  EOH
  action :nothing
end
execute "restart ejabberd" do
  command "sudo ejabberdctl restart"
  action :run
end

