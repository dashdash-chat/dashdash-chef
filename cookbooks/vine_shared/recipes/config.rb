#
# Cookbook Name:: vine_shared
# Recipe:: config
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#
# These things are needed by both vine_shared and vine_ejabberd, so the base role should run them first
#
# Load the config variables from the environment-specific data bag
Chef::Log.info(node.run_state)
node.run_state['config'] = Chef::EncryptedDataBagItem.load(node.chef_environment, "config")
file Chef::Config[:encrypted_data_bag_secret] do
  action :delete  # no need to keep our secrets sitting on disk all in one place!
end

# Make sure our directories exist
[node['dirs']['log'],
 node['dirs']['source'],
 node['dirs']['other']
].each do |dir|
  directory dir do
    owner node.run_state['config']['user']
    group node.run_state['config']['group']
    mode 00755
    recursive true
    action :create
    not_if {File.exists?(dir)}
  end
end
directory node['dirs']['ssl'] do
  owner "root"
  group "root"
  mode 00500
  recursive true
  action :create
  not_if {File.exists?(node['dirs']['ssl'])}
end

# Prepare /etc/hosts
if node.chef_environment == "dev"
  ruby_block "append entry to /etc/hosts" do
    block do
      file = Chef::Util::FileEdit.new("/etc/hosts")
      file.insert_line_if_no_match("/#{node.run_state['config']['domain']}/", "\n127.0.0.1\t#{node.run_state['config']['domain']}\n")
      file.write_file
    end
  end
end

# Create the SSL certificate and key files (the leaf component needs these if it has it's own supervisor!)
['crt', 'key'].each do |type|
  template "#{node['dirs']['ssl']}/ssl_web.#{type}" do
    source "ssl.#{type}.erb"
    owner "root"
    group "root"
    variables :ssl_string => node.run_state['config']['ssl']["web_ssl_#{type}"]
    mode 00644
  end
end
