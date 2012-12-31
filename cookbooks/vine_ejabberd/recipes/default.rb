#
# Cookbook Name:: vine_ejabberd
# Recipe:: default
#
# Copyright 2012, Vine.IM
#
# All rights reserved - Do Not Redistribute
#

env_data = data_bag_item("dev_data", "dev_data")

# Make sure our directories exist
["#{node['source_dir']}"
].each do |dir|
  directory dir do
    mode 0644
    owner env_data["server"]["user"]
    group env_data["server"]["user"]
    recursive true
    action :create
  end
end

# Downdload and install ejabberd
git "#{node['vine_ejabberd']['ejabberd_repo_dir']}" do
  repository "https://github.com/lehrblogger/ejabberd.git"
  # use this HTTP URL, since the SSH URL requires a deploy key
  branch "2.1.x-stanza-restrictions"
  destination "#{node['vine_ejabberd']['ejabberd_repo_dir']}"
  action :sync
end
package "libexpat1-dev"
execute "./configure, make, and install ejabberd" do
  command "./configure && make && sudo make install"
  cwd "#{node['vine_ejabberd']['ejabberd_repo_dir']}/src"
  action :run
end
