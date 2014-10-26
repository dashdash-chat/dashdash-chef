#
# Cookbook Name:: vine_ejabberd
# Recipe:: default
#
# Copyright 2014, Dashdash, Inc.
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
  environment 'HOME' => "/home/#{node.run_state['config']['user']}"
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
    environment 'HOME' => "/home/#{node.run_state['config']['user']}"
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
  environment 'HOME' => "/home/#{node.run_state['config']['user']}"
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

# Set up the cron job to rotate the logs - note that this overwrites the old log, but we have it in Papertrail
cron "rotate ejabberd logs" do
  user "root"
  weekday "6"
  hour "23"
  minute "0"
  command "sudo ejabberdctl reopen_log"
  mailto "lehrburger+vinecron@gmail.com"
end

# Set up the cron job to snapshot the ejabberd database (using both methods) and store it in S3
node.set['s3cmd']['url'] = 'https://github.com/lehrblogger/s3cmd/archive/master.tar.gz'
node.set['s3cmd']['access_key'] = node.run_state['config']['s3']['access_key_id']
node.set['s3cmd']['secret_key'] = node.run_state['config']['s3']['secret_access_key']
node.set['s3cmd']['https'] = true
node.set['s3cmd']['user'] = node.run_state['config']['user']
node.set['s3cmd']['home'] = "/home/#{node.run_state['config']['user']}"
include_recipe "s3cmd"
template "ejabberd_snapshot.sh" do
  path "#{node['dirs']['source']}/ejabberd_snapshot.sh"
  source "ejabberd_snapshot.sh.erb"
end
cron "ejabberd snapshot to s3" do
  user "root"
  hour 9  # run this before the edge calc script
  minute 0
  command "sudo sh #{node['dirs']['source']}/ejabberd_snapshot.sh"
  mailto "lehrburger+vinecron@gmail.com"
end

# Make sure we have the admin users that we definitely need
node.run_state['config']['xmpp_users']['admins'].map {|admin_user|
  [admin_user, node.run_state['config']['xmpp_users']['admin_password']]
}.push(
  [node.run_state['config']['xmlrpc']['leaves_user'], node.run_state['config']['xmlrpc']['leaves_password']],
  [node.run_state['config']['xmlrpc']['graph_user'], node.run_state['config']['xmlrpc']['graph_password']],
  [node.run_state['config']['xmlrpc']['web_user'], node.run_state['config']['xmlrpc']['web_password']],
  [node.run_state['config']['xmlrpc']['helpbot_user'], node.run_state['config']['xmlrpc']['helpbot_password']],
  [node.run_state['config']['xmpp_users']['echo_user'], node.run_state['config']['xmpp_users']['default_password']],
  [node.run_state['config']['xmpp_users']['helpbot_user'], node.run_state['config']['xmpp_users']['helpbot_password']]
).each do |username_password|
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ctl"
    localuser username_password[0]
    localserver node.run_state['config']['domain']
    password username_password[1]
    action :register_or_update
  end
end
# Make sure that admins have the Leaf on their roster
node.run_state['config']['xmpp_users']['admins'].each do |admin_user|
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ctl"
    localuser admin_user
    localserver node.run_state['config']['domain']
    user node.run_state['config']['leaves']['jid_user']
    server "#{node.run_state['config']['leaves']['subdomain']}.#{node.run_state['config']['domain']}"
    nick "Leaf-#{node.chef_environment}"
    group "Dashdash"
    subs "both"
    action :add_rosteritem
  end
end

# Send the ejabberd logs to Papertrail
node.set['papertrail']['watch_files']["#{node['dirs']['log']}/ejabberd/ejabberd.log"  ] = 'ejabberd'
#node.set['papertrail']['watch_files']["#{node['dirs']['log']}/ejabberd/erlang.log"    ] = 'erlang'
