cd ~/Dropbox/projects/vine/vine-web  && knife cookbook upload vine_web      -o cookbooks/
cd ~/Dropbox/projects/vine/vine-xmpp && knife cookbook upload vine_xmpp     -o cookbooks/
cd ~/Dropbox/projects/vine/vine-chef && knife cookbook upload vine_ejabberd -o cookbooks/
cd ~/Dropbox/projects/vine/vine-chef && knife cookbook upload vine_shared   -o cookbooks/
knife role from file roles/*
knife environment from file environments/dev.json
knife data bag from file dev  config.json --secret-file /Volumes/secret_keys/data_bags/prod_key
knife data bag from file prod config.json --secret-file /Volumes/secret_keys/data_bags/dev_key
