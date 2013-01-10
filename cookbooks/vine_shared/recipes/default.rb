#
# Cookbook Name:: vine_shared
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

# Create the nginx.conf file
template "nginx.conf" do
  path "#{node['nginx']['dir']}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :reload, 'service[nginx]'
end

# Set up MySQL, which both vine-web and vine-xmpp need for state
include_recipe "vine_shared::mysql"

# Set up supervisor and it's internal admin page
node.set['supervisor']['inet_port']     = node.run_state['config']['supervisor']['hostport']
node.set['supervisor']['inet_username'] = node.run_state['config']['supervisor']['username']
node.set['supervisor']['inet_password'] = node.run_state['config']['supervisor']['password']
include_recipe "supervisor"
#TODO how to reload on new run to re-establish mysql conn?

# Add commonly-used commands to the bash history (node.run_state['config']['mysql']['root_password'] is nil in prod, which works perfectly)
file "/home/#{node.run_state['config']['user']}/.bash_history" do
  owner node.run_state['config']['user']
  group node.run_state['config']['group']
  mode 00755
  content "history"
  action :create
  not_if {File.size( "/home/#{node.run_state['config']['user']}/.bash_history") > 0}
end
["ps faux | grep",
 "mysql -u root -p#{node.run_state['config']['mysql']['root_password']} -h #{node.run_state['config']['mysql']['host']} -D #{node.run_state['config']['mysql']['main_name']}",
 "tail -f -n 200 #{node['dirs']['log']}/",
# "cd #{node['vine_web']['web_env_dir']} && source bin/activate && cd #{node['vine_web']['web_repo_dir']}",
# "cd #{node['vine_xmpp']['xmpp_env_dir']} && source bin/activate && cd #{node['vine_xmpp']['xmpp_repo_dir']}",
].each do |command|
  ruby_block "append line to history" do
    block do
      file = Chef::Util::FileEdit.new("/home/#{node.run_state['config']['user']}/.bash_history")
      file.insert_line_if_no_match("/[^\s\S]/", command)  # regex never matches anything
      file.write_file
    end
  end
end

