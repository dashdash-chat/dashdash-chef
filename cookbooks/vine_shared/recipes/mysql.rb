env_data = data_bag_item("dev_data", "dev_data")
if node.chef_environment == "dev"
  mysql_connection_info = {:host => env_data["mysql"]["host"], :username => 'root', :password => env_data["mysql"]["root_password"]}
  directory node['vine_shared']['mysql_dir'] do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
  end
  
  # dump or prepare to initialize the main vine database
  [env_data["mysql"]["main_name"]
  ].each do |db_name|
    execute "dump database #{db_name}" do
      command "mysqldump --no-create-info -h #{env_data["mysql"]["host"]} -u root -p#{env_data["mysql"]["root_password"]} #{db_name} > #{node['vine_shared']['mysql_dir']}/#{db_name}.sql"
      #NOTE the --no-create-info flag, so we can try to re-populate our tables with the previous data
      action :run
      only_if {File.exists?("#{node['vine_shared']['mysql_dir']}/#{db_name}.sql")}
      #NOTE only overwrite existing dumps, but if this is the first provision we want to use the init file
    end
    cookbook_file "#{node['vine_shared']['mysql_dir']}/#{db_name}.sql" do
      owner env_data["server"]["user"]
      group env_data["server"]["group"]
      mode 00444
      source "init_#{db_name}.sql"
      action :create_if_missing
    end
  end
  
  # drop and recreate both databases
  [env_data["mysql"]["main_name"],
   env_data["mysql"]["celery_name"]
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
      source "#{table_name}.sql"
      owner env_data["server"]["user"]
      group env_data["server"]["group"]
      mode 00444
      action :create
    end
    mysql_database "create table #{table_name}" do
      connection mysql_connection_info
      database_name env_data["mysql"]["main_name"]
      sql { ::File.open("#{node['vine_shared']['mysql_dir']}/#{table_name}.sql").read }
      action :query
    end
  end
  
  # import the initial databases
  if node['load_dumps']
    # either a dump from our manually-exported files
    cookbook_file "#{node['dirs']['other']}/mysql_dump.sql" do
      owner env_data["server"]["user"]
      group env_data["server"]["group"]
      mode 00444
      source "mysql_dump.sql"
      action :create
    end
    execute "import mysql vine databse" do
      command "mysql -h #{env_data["mysql"]["host"]} -u root -p#{env_data["mysql"]["root_password"]} vine < #{node['dirs']['other']}/mysql_dump.sql"
      action :run
    end
  else
    # or whatever database(s) we had before
    [env_data["mysql"]["main_name"]
    ].each do |db_name|
      execute "import databse #{db_name}" do
        command "mysql -h #{env_data["mysql"]["host"]} -u root -p#{env_data["mysql"]["root_password"]} #{db_name} < #{node['vine_shared']['mysql_dir']}/#{db_name}.sql"
        action :run
      end
    end
  end
  
  # create the users
  [[env_data["mysql"]["web_user"],    env_data["mysql"]["web_password"]],
   [env_data["mysql"]["graph_user"],  env_data["mysql"]["graph_password"]],
   [env_data["mysql"]["celery_user"], env_data["mysql"]["celery_password"]],
   [env_data["mysql"]["leaves_user"], env_data["mysql"]["leaves_password"]]
  ].each do |user_password|
    mysql_database_user user_password[0] do
      connection mysql_connection_info
      password user_password[1]
      action :create
    end
  end
  
  # grant privileges to the web user
  [[env_data["mysql"]["main_name"], 'users',        [:select, :update, :insert]],
   [env_data["mysql"]["main_name"], 'invites',      [:select, :update, :insert]],
   [env_data["mysql"]["main_name"], 'demos',        [:select, :update, :insert]],
   [env_data["mysql"]["main_name"], 'edges',        [:select]],
   [env_data["mysql"]["main_name"], 'vinebots',     [:select]],
   [env_data["mysql"]["main_name"], 'user_tasks',   [:select, :insert]]
  ].each do |db_table_privileges|
    mysql_database_user env_data["mysql"]["web_user"] do
      connection mysql_connection_info
      database_name db_table_privileges[0]
      table db_table_privileges[1]
      privileges db_table_privileges[2]
      host '%'
      action :grant
    end
  end
  
  # grant privileges to the graph user
  [[env_data["mysql"]["main_name"], 'invites',            [:select]],
   [env_data["mysql"]["main_name"], 'commands',           [:select]],
   [env_data["mysql"]["main_name"], 'messages',           [:select]],
   [env_data["mysql"]["main_name"], 'recipients',         [:select]],
   [env_data["mysql"]["main_name"], 'users',              [:select]],
   [env_data["mysql"]["main_name"], 'blocks',             [:select]],
   [env_data["mysql"]["main_name"], 'artificial_follows', [:select]],
   [env_data["mysql"]["main_name"], 'twitter_follows',    [:select]],
   [env_data["mysql"]["main_name"], 'edges',              [:select]]
  ].each do |db_table_privileges|
    mysql_database_user env_data["mysql"]["graph_user"] do
      connection mysql_connection_info
      database_name db_table_privileges[0]
      table db_table_privileges[1]
      privileges db_table_privileges[2]
      host '%'
      action :grant
    end
  end
  
  # grant privileges to the celery user
  [[env_data["mysql"]["celery_name"], nil,             [:all]],  #NOTE this will replace 'nil' with the default of '*'
   [env_data["mysql"]["main_name"], 'users',           [:select]],
   [env_data["mysql"]["main_name"], 'twitter_follows', [:select, :update, :insert, :delete]]
  ].each do |db_table_privileges|
    mysql_database_user env_data["mysql"]["celery_user"] do
      connection mysql_connection_info
      database_name db_table_privileges[0]
      table db_table_privileges[1]
      privileges db_table_privileges[2]
      host '%'
      action :grant
    end
  end
  
  # grant privileges to the leaves user
  [[env_data["mysql"]["main_name"], 'users',        [:select, :update, :insert]],
   [env_data["mysql"]["main_name"], 'edges',        [:select, :update, :insert, :delete]],
   [env_data["mysql"]["main_name"], 'vinebots',     [:select, :update, :insert, :delete]],
   [env_data["mysql"]["main_name"], 'participants', [:select, :update, :insert, :delete]],
   [env_data["mysql"]["main_name"], 'topics',       [:select, :update, :insert, :delete]],
   [env_data["mysql"]["main_name"], 'commands',     [:select, :insert]],
   [env_data["mysql"]["main_name"], 'messages',     [:select, :insert]],
   [env_data["mysql"]["main_name"], 'recipients',   [:insert]]#,
   #The following are needed only for the destructive /purge_user command, so don't leave them as granted most of the time?
   # [env_data["mysql"]["main_name"], 'user_tasks',         [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'demos',              [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'invites',            [:select, :delete, :update]],
   # [env_data["mysql"]["main_name"], 'blocks',             [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'artificial_follows', [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'twitter_follows',    [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'recipients',         [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'messages',           [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'commands',           [:select, :delete]],
   # [env_data["mysql"]["main_name"], 'users',              [:select, :delete]]
  ].each do |db_table_privileges|
    mysql_database_user env_data["mysql"]["leaves_user"] do
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
end