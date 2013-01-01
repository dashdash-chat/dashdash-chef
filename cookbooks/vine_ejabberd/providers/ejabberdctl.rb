action :register do
  execute "register #{new_resource.localuser}@#{new_resource.localserver}" do
    not_if "ejabberdctl check_account #{new_resource.localuser} #{new_resource.localserver}"
    command "ejabberdctl register #{new_resource.localuser} #{new_resource.localserver} #{new_resource.password}"
  end
end

action :add_rosteritem do
  execute "add #{new_resource.user}@#{new_resource.server} to #{new_resource.localuser}@#{new_resource.localserver}'s roster" do
    command "ejabberdctl add_rosteritem #{new_resource.localuser} #{new_resource.localserver} #{new_resource.user} #{new_resource.server} #{new_resource.nick} #{new_resource.group} #{new_resource.subs}"
  end
end
