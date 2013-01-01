#
# Cookbook Name:: vine_shared
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
env_data = data_bag_item("dev_data", "dev_data")

if node.chef_environment == "dev"
  ruby_block "append entry to /etc/hosts" do
    block do
      file = Chef::Util::FileEdit.new("/etc/hosts")
      file.insert_line_if_no_match("/#{env_data['server']['domain']}/", "\n127.0.0.1\t#{env_data['server']['domain']}\n")
      file.write_file
    end
  end
end

include_recipe "vine_shared::mysql"
