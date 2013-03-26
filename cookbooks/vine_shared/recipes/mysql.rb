#
# Cookbook Name:: vine_shared
# Recipe:: mysql
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

include_recipe "database::mysql"
mysql_connection_info = {:host => node.run_state['config']['mysql']['host'], :username => node.run_state['config']['mysql']['root_user'], :password => node.run_state['config']['mysql']['root_password']}

# We don't want to mess with the databases or tables in prod
if node.chef_environment == "dev"
  include_recipe "mysql::server"
  node.set['vine_shared']['mysql_dir'] = "#{node['dirs']['source']}/mysql"
  directory node['vine_shared']['mysql_dir'] do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
  end

  # dump or prepare to initialize the main vine database
  [node.run_state['config']['mysql']['main_name']
  ].each do |db_name|
    execute "dump database #{db_name}" do
      command "mysqldump --no-create-info --complete-insert -h #{node.run_state['config']['mysql']['host']} -u #{node.run_state['config']['mysql']['root_user']} -p#{node.run_state['config']['mysql']['root_password']} #{db_name} > #{node['vine_shared']['mysql_dir']}/#{db_name}.sql"
      #NOTE use the --no-create-info flag, so we can try to re-populate our tables with the previous data
      action :run
      only_if {File.exists?("#{node['vine_shared']['mysql_dir']}/#{db_name}.sql")}
      #NOTE only overwrite existing dumps, but if this is the first provision we want to use the init file
    end
    cookbook_file "#{node['vine_shared']['mysql_dir']}/#{db_name}.sql" do
      owner node.run_state['config']['user']
      group node.run_state['config']['group']
      mode 00444
      source "init_#{db_name}.sql"
      action :create_if_missing
    end
  end

  # drop and recreate both databases
  [node.run_state['config']['mysql']['main_name'],
   node.run_state['config']['mysql']['celery_name']
  ].each do |db_name|
    mysql_database db_name do
      connection mysql_connection_info
      action :drop
    end
    mysql_database db_name do
      connection mysql_connection_info
      encoding 'utf8'
      collation 'utf8_bin'
      action :create
    end
  end
  
  # create the tables
  ['users',
   'user_tasks',
   'demos',
   'invites',
   'invitees',
   'vinebots',
   'topics',
   'participants',
   'edges',
   'commands',
   'messages',
   'recipients',
   'blocks',
   'artificial_follows',
   'twitter_follows'
  ].each do |table_name|
    cookbook_file "#{node['vine_shared']['mysql_dir']}/#{table_name}.sql" do
      source "tables/#{table_name}.sql"
      owner node.run_state['config']['user']
      group node.run_state['config']['group']
      mode 00444
      action :create
    end
    mysql_database "create table #{table_name}" do
      connection mysql_connection_info
      database_name node.run_state['config']['mysql']['main_name']
      sql { ::File.open("#{node['vine_shared']['mysql_dir']}/#{table_name}.sql").read }
      action :query
    end
  end
  
  unless node.run_list.include?("recipe[vine_shared::load_dumps]")  #LATER make this cleaner
    # import whatever database(s) we had before
    [node.run_state['config']['mysql']['main_name']
    ].each do |db_name|
      execute "import database #{db_name}" do
        command "mysql -h #{node.run_state['config']['mysql']['host']} -u #{node.run_state['config']['mysql']['root_user']} -p#{node.run_state['config']['mysql']['root_password']} #{db_name} < #{node['vine_shared']['mysql_dir']}/#{db_name}.sql"
        action :run
      end
    end
  end
end

# But we do want to make sure that users exist with the proper permissions in prod
# create the users
[[node.run_state['config']['mysql']['web_user'],    node.run_state['config']['mysql']['web_password']],
 [node.run_state['config']['mysql']['graph_user'],  node.run_state['config']['mysql']['graph_password']],
 [node.run_state['config']['mysql']['celery_user'], node.run_state['config']['mysql']['celery_password']],
 [node.run_state['config']['mysql']['help_user'],   node.run_state['config']['mysql']['help_password']],
 [node.run_state['config']['mysql']['leaves_user'], node.run_state['config']['mysql']['leaves_password']]
].each do |user_password|
  mysql_database_user user_password[0] do
    connection mysql_connection_info
    password user_password[1]
    action :create
  end
end

# grant privileges to the web user
[[node.run_state['config']['mysql']['main_name'], 'users',        [:select, :update, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'invites',      [:select, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'invitees',     [:select, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'demos',        [:select, :update, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'edges',        [:select]],
 [node.run_state['config']['mysql']['main_name'], 'blocks',       [:select]],
 [node.run_state['config']['mysql']['main_name'], 'vinebots',     [:select]],
 [node.run_state['config']['mysql']['main_name'], 'user_tasks',   [:select, :insert]]
].each do |db_table_privileges|
  mysql_database_user node.run_state['config']['mysql']['web_user'] do
    connection mysql_connection_info
    database_name db_table_privileges[0]
    table db_table_privileges[1]
    privileges db_table_privileges[2]
    host '%'
    action :grant
  end
end

# grant privileges to the graph user
[[node.run_state['config']['mysql']['main_name'], 'invites',            [:select]],
 [node.run_state['config']['mysql']['main_name'], 'invitees',           [:select]],
 [node.run_state['config']['mysql']['main_name'], 'commands',           [:select]],
 [node.run_state['config']['mysql']['main_name'], 'messages',           [:select]],
 [node.run_state['config']['mysql']['main_name'], 'recipients',         [:select]],
 [node.run_state['config']['mysql']['main_name'], 'users',              [:select]],
 [node.run_state['config']['mysql']['main_name'], 'blocks',             [:select]],
 [node.run_state['config']['mysql']['main_name'], 'artificial_follows', [:select]],
 [node.run_state['config']['mysql']['main_name'], 'twitter_follows',    [:select]],
 [node.run_state['config']['mysql']['main_name'], 'edges',              [:select]]
].each do |db_table_privileges|
  mysql_database_user node.run_state['config']['mysql']['graph_user'] do
    connection mysql_connection_info
    database_name db_table_privileges[0]
    table db_table_privileges[1]
    privileges db_table_privileges[2]
    host '%'
    action :grant
  end
end

# grant privileges to the celery user
[[node.run_state['config']['mysql']['celery_name'], nil,             [:all]],  #NOTE it will replace 'nil' with the default of '*'
 [node.run_state['config']['mysql']['main_name'], 'users',           [:select]],
 [node.run_state['config']['mysql']['main_name'], 'twitter_follows', [:select, :update, :insert, :delete]]
].each do |db_table_privileges|
  mysql_database_user node.run_state['config']['mysql']['celery_user'] do
    connection mysql_connection_info
    database_name db_table_privileges[0]
    table db_table_privileges[1]
    privileges db_table_privileges[2]
    host '%'
    action :grant
  end
end

# grant privileges to the help user
[[node.run_state['config']['mysql']['main_name'], 'users',        [:select, :update]],
 [node.run_state['config']['mysql']['main_name'], 'edges',        [:select]],
 [node.run_state['config']['mysql']['main_name'], 'vinebots',     [:select]],
 [node.run_state['config']['mysql']['main_name'], 'topics',       [:select]],
 [node.run_state['config']['mysql']['main_name'], 'participants', [:select]],
 [node.run_state['config']['mysql']['main_name'], 'commands',     [:select]],
 [node.run_state['config']['mysql']['main_name'], 'messages',     [:select]],
 [node.run_state['config']['mysql']['main_name'], 'recipients',   [:select]]
].each do |db_table_privileges|
  mysql_database_user node.run_state['config']['mysql']['help_user'] do
    connection mysql_connection_info
    database_name db_table_privileges[0]
    table db_table_privileges[1]
    privileges db_table_privileges[2]
    host '%'
    action :grant
  end
end

# grant privileges to the leaves user
leaves_privileges = [[node.run_state['config']['mysql']['main_name'], 'users',        [:select, :update, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'edges',        [:select, :update, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'vinebots',     [:select, :update, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'participants', [:select, :update, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'topics',       [:select, :update, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'commands',     [:select, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'messages',     [:select, :insert]],
 [node.run_state['config']['mysql']['main_name'], 'recipients',   [:insert]],
 [node.run_state['config']['mysql']['main_name'], 'invites',      [:select, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'invitees',     [:select, :insert, :delete]],
 [node.run_state['config']['mysql']['main_name'], 'blocks' ,      [:select, :insert, :delete]]]
if node.chef_environment == 'dev'
  # The following are needed only for the destructive /purge_user command, so be careful and restrict them to the dev environment
  leaves_privileges = leaves_privileges + [
    [node.run_state['config']['mysql']['main_name'], 'user_tasks',         [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'demos',              [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'invites',            [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'invitees',           [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'blocks',             [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'artificial_follows', [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'twitter_follows',    [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'recipients',         [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'messages',           [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'commands',           [:select, :delete]],
    [node.run_state['config']['mysql']['main_name'], 'users',              [:select, :delete]]]
end
leaves_privileges.each do |db_table_privileges|
  mysql_database_user node.run_state['config']['mysql']['leaves_user'] do
    connection mysql_connection_info
    database_name db_table_privileges[0]
    table db_table_privileges[1]
    privileges db_table_privileges[2]
    host '%'
    action :grant
  end
end

# flush priveleges
mysql_database "flush the privileges" do
  connection mysql_connection_info
  sql "FLUSH PRIVILEGES"
  action :query
end

#TODO delete mysql dump files so they arent on disk?
