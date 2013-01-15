#
# Cookbook Name:: vine_shared
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

# Create the nginx.conf file
domain = node.run_state['config']['domain']
if node.run_list.include?("role[xmpp]")  #LATER sigh, not sure how to make this neater
  domain = "#{node.run_state['config']['leaves']['subdomain']}.#{node.run_state['config']['domain']}"
end
template "nginx.conf" do
  path "#{node['nginx']['dir']}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables :domain => domain
  notifies :reload, 'service[nginx]'
end

# Set up the cron job to rotate the logs - note that this overwrites the old log, but we have it in Papertrail
cron "rotate nginx access logs" do
  user "root"
  weekday "6"
  hour "23"
  minute "05"
  command "mv #{node['dirs']['log']}/nginx/access.log #{node['dirs']['log']}/nginx/access-old.log && kill -USR1 `cat master.nginx.pid`"
  mailto "lehrburger+vinecron@gmail.com"
end
cron "rotate nginx error logs" do
  user "root"
  weekday "6"
  hour "23"
  minute "10"
  command "mv #{node['dirs']['log']}/nginx/error.log  #{node['dirs']['log']}/nginx/error-old.log  && kill -USR1 `cat master.nginx.pid`"
  mailto "lehrburger+vinecron@gmail.com"
end

# Set up MySQL, which both vine-web and vine-xmpp need for state
include_recipe "vine_shared::mysql"

# Set up supervisor and it's internal admin page
node.set['supervisor']['inet_port']     = node.run_state['config']['supervisor']['hostport']
node.set['supervisor']['inet_username'] = node.run_state['config']['supervisor']['username']
node.set['supervisor']['inet_password'] = node.run_state['config']['supervisor']['password']
include_recipe "supervisor"
#TODO how to reload on new run to re-establish mysql conn? supervisorctl restart all? test this in dashboard first!

# Send the nginx and Supervisor logs to Papertrail
node.set['papertrail']['watch_files']["#{node['dirs']['log']}/nginx/access.log"          ] = 'nginx_access'
node.set['papertrail']['watch_files']["#{node['dirs']['log']}/nginx/error.log"           ] = 'nginx_error'
node.set['papertrail']['watch_files']["#{node['dirs']['log']}/supervisor/supervisord.log"] = 'supervisord'
