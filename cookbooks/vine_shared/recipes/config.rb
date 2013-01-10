node.run_state['config'] = Chef::EncryptedDataBagItem.load(node.chef_environment, "config")
file Chef::Config[:encrypted_data_bag_secret] do
  action :delete  # no need to keep our secrets sitting on disk all in one place!
end

# Make sure our directories exist
["#{node['dirs']['log']}",
 "#{node['dirs']['source']}",
 "#{node['dirs']['other']}"
].each do |dir|
  directory dir do
    owner node.run_state['config']['server']['user']
    group node.run_state['config']['server']['group']
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
