#
# Cookbook Name:: vine_ejabberd
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#
env_data = data_bag_item("dev_data", "dev_data")

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
service "ejabberd" do
  service_name    "ejabberd"
  start_command   "ejabberdctl start"
  stop_command    "ejabberdctl stop"
  status_command  "ejabberdctl status"
  restart_command "ejabberdctl restart"
  supports ({
    :start   => true,
    :stop    => true,
    :status  => true,
    :restart => true,
    :reload  => false
  })
  action :start
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
    command "cp ebin/#{module_name}.beam #{node['vine_ejabberd']['ejabberd_lib_dir']}/ebin/"
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
    (cd xmlrpc-1.13/src && make && cp ../ebin/*.beam #{node['vine_ejabberd']['ejabberd_lib_dir']}/ebin/)
  EOH
  action :nothing
end

# Render the SSL and ejabberd.cfg templates, and restart ejabberd
template "ssl_both.crt" do
  path "#{node['ssl_dir']}/ssl_both.crt"
  source "ssl_both.crt.erb"
  owner "root"
  group "root"
  variables ({
    :ssl_crt => env_data["server"]["web_ssl_crt"],
    :ssl_key => env_data["server"]["web_ssl_key"]
  })
  mode 0600
end
template "ejabberd.cfg" do
  path "#{node['vine_ejabberd']['ejabberd_cfg_dir']}/ejabberd.cfg"
  source "ejabberd.cfg.erb"
  variables :env_data => env_data
  notifies :restart, "service[ejabberd]", :immediately
end

# Initialize the users
if node['load_dumps']
  # Either using a previous dump, relying on vine_shared::mysql to create it's own database
  cookbook_file "#{node['dirs']['other']}/ejabberd_dump.erl" do
    owner env_data["server"]["user"]
    group env_data["server"]["group"]
    mode 00444
    source "ejabberd_dump.erl"
    action :create
  end
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ejabberdctl"
    file "#{node['dirs']['other']}/ejabberd_dump.erl"
    action :load
  end
else
  # Or just the admin users that we definitely need
  test = env_data["xmpp"]["admin_users"].map {|admin_user|
    [admin_user, env_data["xmpp"]["admin_password"]]
  }.push(
    [env_data["xmlrpc"]["leaves_user"], env_data["xmlrpc"]["leaves_password"]],
    [env_data["xmlrpc"]["graph_user"], env_data["xmlrpc"]["graph_password"]],
    [env_data["xmlrpc"]["web_user"], env_data["xmlrpc"]["web_password"]]
  ).each do |username_password|
    vine_ejabberd_ctl "ctl" do
      provider "vine_ejabberd_ejabberdctl"
      localuser username_password[0]
      localserver env_data["server"]["domain"]
      password username_password[1]
      action :register
    end
  end
end
# Change the admin passwords anyway
env_data["xmpp"]["admin_users"].each do |admin_user|
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ejabberdctl"
    localuser admin_user
    localserver env_data["server"]["domain"]
    user env_data["leaves"]["xmpp_user"]
    server "#{env_data["leaves"]["domain_prefix"]}.#{env_data["server"]["domain"]}"
    nick "Leaf"
    group "Vine-#{node.chef_environment}"
    subs "both"
    action :add_rosteritem
  end
end
