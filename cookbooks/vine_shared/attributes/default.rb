default['vine_shared']['mysql_dir']           = "#{Chef::Environment.load(node.chef_environment).default_attributes['dirs']['source']}/mysql"
default['vine_shared']['supervisord_log_dir'] = "#{Chef::Environment.load(node.chef_environment).default_attributes['dirs']['log']}/supervisord"
