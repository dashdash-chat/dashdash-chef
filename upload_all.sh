knife cookbook upload vine_shared   -o ~/Dropbox/projects/vine/vine-chef/cookbooks/
knife cookbook upload vine_ejabberd -o ~/Dropbox/projects/vine/vine-chef/cookbooks/
knife cookbook upload vine_web      -o ~/Dropbox/projects/vine/vine-web/cookbooks/
knife cookbook upload vine_xmpp     -o ~/Dropbox/projects/vine/vine-xmpp/cookbooks/
knife role from file roles/*
knife environment from file environments/dev.json
knife environment from file environments/prod.json

knife data bag from file dev  config.json    --secret-file /Volumes/secret_keys/data_bags/dev_key
# knife data bag from file prod config.json

# knife data bag from file dev vine_web.json
# knife data bag from file dev vine_xmpp.json
# knife data bag from file prod vine_web.json
# knife data bag from file prod vine_xmpp.json
