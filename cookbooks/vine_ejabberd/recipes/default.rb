#
# Cookbook Name:: vine_ejabberd
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

# Downdload and install ejabberd, then make sure it runs
ejabberd_repo_dir = "#{node['dirs']['source']}/ejabberd"
git ejabberd_repo_dir do
  repository "https://github.com/lehrblogger/ejabberd.git"
  # use this HTTP URL, since the SSH URL requires a deploy key
  branch "2.1.x-stanza-restrictions"
  destination ejabberd_repo_dir
  action :sync
end
include_recipe "erlang"
include_recipe "zlib"
packages = value_for_platform(
    ["centos","redhat","fedora","amazon","scientific"] => {'default' => ['openssl-devel']},
    "default" => ['libssl-dev']
  )
packages.each do |devpkg|
  package devpkg
end
package "libexpat1-dev"
execute "./configure, make, and install ejabberd" do
  command "./configure && make && sudo make install"
  cwd "#{ejabberd_repo_dir}/src"
  action :run
end
directory node['ejabberd']['log_dir'] do
    owner node.run_state['config']['user']
    group node.run_state['config']['group']
    mode 00755
    recursive true
    action :create
    not_if {File.exists?(node['ejabberd']['log_dir'])}
end
service "ejabberd" do
  service_name    "ejabberd"
  start_command   "ejabberdctl start --logs #{node['ejabberd']['log_dir']}"
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

# Download and install the modules, but we'll restart ejabberd later
modules_repo_dir = "#{node['dirs']['source']}/ejabberd-modules"
git "#{modules_repo_dir}" do
  repository "https://github.com/lehrblogger/ejabberd-modules.git"
  branch "master"
  destination "#{modules_repo_dir}"
  action :sync
end
ejabberd_lib_dir = "/lib/ejabberd"
['mod_admin_extra', 'ejabberd_xmlrpc'].each do |module_name|
  execute "build #{module_name} module for ejabberd" do
    command "./build.sh"
    cwd "#{modules_repo_dir}/#{module_name}/trunk"
    action :run
  end
  execute "install #{module_name} module for ejabberd" do
    command "cp ebin/#{module_name}.beam #{ejabberd_lib_dir}/ebin/"
    cwd "#{modules_repo_dir}/#{module_name}/trunk"
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
    (cd xmlrpc-1.13/src && make && cp ../ebin/*.beam #{ejabberd_lib_dir}/ebin/)
  EOH
  action :nothing
end

# Render the SSL and ejabberd.cfg templates (note that in prod you need different certs for IM and http!), and restart ejabberd
['ejabberd', 'web'].each do |file_name|
  cert_name = file_name
  unless node.run_list.include?("role[ejabberd]")  #LATER make this cleaner
    cert_name = 'ejabberd'  # use the same cert for both files on dev
  end
  template "#{node['dirs']['ssl']}/#{file_name}_ssl_both.crt" do
    source "ssl_both.crt.erb"
    owner "root"
    group "root"
    variables ({
      :ssl_crt => node.run_state['config']['ssl']["#{cert_name}_crt"],
      :ssl_key => node.run_state['config']['ssl']["#{cert_name}_key"]
    })
    mode 0600
  end
end

template "ejabberd.cfg" do
  path "/etc/ejabberd/ejabberd.cfg"
  source "ejabberd.cfg.erb"
  notifies :restart, "service[ejabberd]", :immediately
end

# Make sure we have the admin users that we definitely need
node.run_state['config']['xmpp_users']['admins'].map {|admin_user|
  [admin_user, node.run_state['config']['xmpp_users']['admin_password']]
}.push(
  [node.run_state['config']['xmlrpc']['leaves_user'], node.run_state['config']['xmlrpc']['leaves_password']],
  [node.run_state['config']['xmlrpc']['graph_user'], node.run_state['config']['xmlrpc']['graph_password']],
  [node.run_state['config']['xmlrpc']['web_user'], node.run_state['config']['xmlrpc']['web_password']]
).each do |username_password|
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ejabberdctl"
    localuser username_password[0]
    localserver node.run_state['config']['domain']
    password username_password[1]
    action :register_or_update
  end
end
# Make sure that admins have the Leaf on their roster
node.run_state['config']['xmpp_users']['admins'].each do |admin_user|
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ejabberdctl"
    localuser admin_user
    localserver node.run_state['config']['domain']
    user node.run_state['config']['leaves']['jid_user']
    server "#{node.run_state['config']['leaves']['subdomain']}.#{node.run_state['config']['domain']}"
    nick "Leaf-#{node.chef_environment}"
    group "Vine"
    subs "both"
    action :add_rosteritem
  end
end
