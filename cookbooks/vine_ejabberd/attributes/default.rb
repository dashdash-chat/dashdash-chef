default['vine_ejabberd']['ejabberd_repo_dir'] = "#{Chef::Environment.load(node.chef_environment).default_attributes['dirs']['source']}/ejabberd"
default['vine_ejabberd']['modules_repo_dir']  = "#{Chef::Environment.load(node.chef_environment).default_attributes['dirs']['source']}/ejabberd-modules"
default['vine_ejabberd']['ejabberd_lib_dir'] = "/lib/ejabberd"
default['vine_ejabberd']['ejabberd_cfg_dir'] = "/etc/ejabberd"
default['vine_ejabberd']['ejabberdctl']['retries'] = 6
default['vine_ejabberd']['ejabberdctl']['retry_delay'] = 5
#TODO ejabberd logs
