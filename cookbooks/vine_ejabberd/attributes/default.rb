default['vine_ejabberd']['ejabberd_repo_dir'] = "#{Chef::Environment.load(node.chef_environment).default_attributes['source_dir']}/ejabberd"
default['vine_ejabberd']['modules_repo_dir']  = "#{Chef::Environment.load(node.chef_environment).default_attributes['source_dir']}/ejabberd-modules"
default['vine_ejabberd']['ejabberd_dir'] = "/lib/ejabberd"