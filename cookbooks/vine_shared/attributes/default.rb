default['vine_shared']['mysql_dir'] = "#{Chef::Environment.load(node.chef_environment).default_attributes['dirs']['source']}/mysql"
default['supervisor']['logfile_maxbytes'] = '50MB'
default['supervisor']['logfile_backups'] = 10
default['supervisor']['loglevel'] = 'info'
default['supervisor']['nodaemon'] = false
