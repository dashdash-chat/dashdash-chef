#
# Cookbook Name:: vine_shared
# Recipe:: config
#
# Copyright 2013, Dashdash, Inc.
#
# All rights reserved - Do Not Redistribute
#
# These things are needed by both vine_shared and vine_ejabberd, so the base role should run them first

# Load the config variables from the environment-specific data bag
node.run_state['config'] = Chef::EncryptedDataBagItem.load(node.chef_environment, "config")
# file Chef::Config[:encrypted_data_bag_secret] do
#   action :delete  # no need to keep our secret key sitting on disk! ... oh maybe we do need it for later for the deploy keys
# end

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

# Create the SSL certificate and key files (the leaf component needs these if it has it's own supervisor!)
if node.run_list.include?("role[xmpp]")  #LATER make this cleaner
  role = 'xmpp'
elsif node.run_list.include?("role[web]")  # We're relying on the fact that we don't use these roles on dev
  role = 'web'
else
  role = 'ejabberd'
end
['crt', 'key'].each do |type|
  template "#{node['dirs']['ssl']}/ssl.#{type}" do
    source "ssl.#{type}.erb"
    owner "root"
    group "root"
    variables :ssl_string => node.run_state['config']['ssl']["#{role}_#{type}"]
    mode 00644
  end
end

# Set up papertrail to archive our logs. Note this only matters if we include the recipe in a run list!
node.set['papertrail']['remote_port'] = node.run_state['config']['papertrail']['port']
if node.chef_environment == "dev"
  node.set['papertrail']['hostname_name'] = 'vagrant'
else
  node.set['papertrail']['hostname_name'] = Chef::Config[:node_name]
end
node.set['papertrail']['watch_files'] = {}  # we'll merge things into this hash later

# On dev, prepare etc hosts and the MySQL root password
if node.chef_environment == "dev"
  ruby_block "append entry to /etc/hosts" do
    block do
      file = Chef::Util::FileEdit.new("/etc/hosts")
      file.insert_line_if_no_match("/#{node.run_state['config']['domain']}/", "\n127.0.0.1\t#{node.run_state['config']['domain']}\n")
      file.write_file
    end
  end
  
  node.set['mysql']['server_root_password'] = node.run_state['config']['mysql']['root_password']
  node.set['mysql']['server_root_user'] = node.run_state['config']['mysql']['root_user']
end

# Add commonly-used commands to the bash history (is nil in prod, which works perfectly)
bash_history = "/home/#{node.run_state['config']['user']}/.bash_history"
file bash_history do
  owner node.run_state['config']['user']
  group node.run_state['config']['group']
  mode 00755
  content "history"  # Chef::Util::FileEdit needs the file not to be blank
  action :create
  not_if {File.exists?(bash_history) and File.size(bash_history) > 0}
end
mysql_root_password = ''
if node.chef_environment == "dev"  # Don't put the root password in the .bash_history in prod!
  mysql_root_password = node.run_state['config']['mysql']['root_password']
end
# TODO move this into a resource so it's not copy-pasted in vine-xmpp and vine-web
["ps faux | grep",
 "sudo tail -f -n 100 /var/log/chef/client.log",
 "mysql -u #{node.run_state['config']['mysql']['root_user']} -p#{mysql_root_password} -h #{node.run_state['config']['mysql']['host']} -D #{node.run_state['config']['mysql']['main_name']}",
 "tail -f -n 200 #{node['dirs']['log']}/"
].each do |command|
  ruby_block "append line to history" do
    block do
      file = Chef::Util::FileEdit.new(bash_history)
      file.insert_line_if_no_match(command, command)  # regex never matches anything
      file.write_file
    end
  end
end
