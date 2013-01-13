#
# Cookbook Name:: vine_shared
# Recipe:: db_dump
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#
# Run this to load the databases from a previous state. Be sure the recipe is executed before any application logic is running!

# Only do this in dev! In prod we need to be much more careful
if node.chef_environment == 'dev'
  # Prepare the dump files
  ['ejabberd_dump.erl', 'mysql_dump.sql'].each do |dump_file|
    cookbook_file "#{node['dirs']['other']}/#{dump_file}" do
      owner node.run_state['config']['user']
      group node.run_state['config']['group']
      mode 00444
      source "/dumps/#{dump_file}"
      action :create
    end
  end
  # Load one into ejabberd
  vine_ejabberd_ctl "ctl" do
    provider "vine_ejabberd_ctl"
    file "#{node['dirs']['other']}/ejabberd_dump.erl"
    action :load
  end
  # Load the other into MySQL
  execute "import mysql vine databse" do
    command "mysql -h #{node.run_state['config']['mysql']['host']}  -u #{node.run_state['config']['mysql']['root_user']} -p#{node.run_state['config']['mysql']['root_password']} vine < #{node['dirs']['other']}/mysql_dump.sql"
    action :run
  end
end
