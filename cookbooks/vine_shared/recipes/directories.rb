env_data = data_bag_item("dev_data", "dev_data")

# Make sure our directories exist
["#{node['dirs']['log']}",
 "#{node['dirs']['source']}",
 "#{node['dirs']['other']}"
].each do |dir|
  directory dir do
    owner env_data["server"]["user"]
    group env_data["server"]["group"]
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
