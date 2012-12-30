env_data = data_bag_item("dev_data", "dev_data")

if node.chef_environment == "dev"
  node.set['mysql']['server_root_password'] = env_data["mysql"]["root_password"]
  mysql_connection_info = {:host => env_data["mysql"]["host"], :username => 'root', :password => env_data["mysql"]["root_password"]}
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
end
