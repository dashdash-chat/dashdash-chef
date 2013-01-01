Vagrant::Config.run do |config|
  
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
  config.vm.customize ["modifyvm", :id, "--memory", 2048]
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  
  config.vm.forward_port 80,80
  config.vm.forward_port 443,443
  config.vm.forward_port 5222, 5222
  config.vm.forward_port 5237, 5237
  config.vm.forward_port 5281, 5281
  
  config.vm.provision :chef_client do |chef| 
    chef.chef_server_url = "https://api.opscode.com/organizations/vine"
    chef.validation_key_path = "/Volumes/secret_keys/vine-validator.pem"
    chef.validation_client_name = "vine-validator"
    chef.node_name = "dev_all"
    chef.environment = "dev"
    chef.run_list = [
      "role[ejabberd]"
    ]
  end
  
end
