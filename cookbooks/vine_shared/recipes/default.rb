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
#TODO how to reload on new run to re-establish mysql conn? supervisorctl restart all? test this in dashboard first!
