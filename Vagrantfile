Vagrant::Config.run do |config|
  
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
  
  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "https://api.opscode.com/organizations/vine"
    chef.validation_key_path = "./.chef/vine-validator.pem"
    chef.validation_client_name = "vine-validator"
    chef.node_name = "dev_all"
  end
  
end
