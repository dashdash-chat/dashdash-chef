#
# Cookbook Name:: vine_shared
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
env_data = data_bag_item("dev_data", "dev_data")

# Make sure our directories exist
[node['dirs']['log'],
 node['dirs']['source'],
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

# Set up the basic supervisor file
#include_recipe "supervisord"
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
  notifies :restart, 'service[supervisor]'
end

include_recipe "vine_shared::mysql"
