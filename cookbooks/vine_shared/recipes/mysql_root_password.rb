env_data = data_bag_item("dev_data", "dev_data")
node.set['mysql']['server_root_password'] = env_data["mysql"]["root_password"]