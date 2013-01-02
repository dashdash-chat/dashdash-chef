#
# Cookbook Name:: vine_shared
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#
env_data = data_bag_item("dev_data", "dev_data")

# Make sure our directories exist
[node['dirs']['log'],
 node['dirs']['source'],
 node['dirs']['ssl'],
 node['vine_shared']['supervisord_log_dir']
].each do |dir|
  directory dir do
    mode 0644
    owner env_data["server"]["user"]
    group env_data["server"]["user"]
    recursive true
    action :create
  end
end
directory node['dirs']['ssl'] do
  mode 0400
  owner "root"
  group "root"
  recursive true
  action :create
end

# Prepare /etc/hosts
if node.chef_environment == "dev"
  ruby_block "append entry to /etc/hosts" do
    block do
      file = Chef::Util::FileEdit.new("/etc/hosts")
      file.insert_line_if_no_match("/#{env_data['server']['domain']}/", "\n127.0.0.1\t#{env_data['server']['domain']}\n")
      file.write_file
    end
  end
end

# Create the SSL certificate and key files
["crt",
 "key"
].each do |type|
  template "ssl_web.#{type}" do
    path "#{node['dirs']['ssl']}/ssl_web.#{type}"
    source "ssl.#{type}.erb"
    owner "root"
    group "root"
    variables :ssl_string => env_data["server"]["web_ssl_#{type}"]
    mode 0644
  end
end

# Create the nginx.conf file
template "nginx.conf" do
  path "#{node['nginx']['dir']}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables :env_data => env_data
  notifies :reload, 'service[nginx]'
end

# Set up the basic supervisor file
template "supervisord.conf" do
  path "/etc/supervisor/supervisord.conf"
  source "supervisord.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables ({
    :log_dir => "#{node['vine_shared']['supervisord_log_dir']}",
    :env_data => env_data
  })
  # No need to start supervisord yet, since there are no programs
end

# Set up MySQL, which both vine-web and vine-xmpp need for state
include_recipe "vine_shared::mysql"

# Add commonly-used commands to the bash history (env_data['mysql']['root_password'] is nil in prod, which works perfectly)
["mysql -u root -p#{env_data['mysql']['root_password']} -h #{env_data['mysql']['host']} -D #{env_data['mysql']['main_name']}",
 "tail -f #{node['dirs']['log']}/"
].each do |command|
  ruby_block "append line to history" do
    block do
      file = Chef::Util::FileEdit.new("/home/#{env_data["server"]["user"]}/.bash_history")
      file.insert_line_if_no_match("/[^\s\S]/", command)  # regex never matches anything
      file.write_file
    end
  end
end

