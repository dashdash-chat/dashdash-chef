Useful Commands
===============

rvmsudo vagrant destroy && knife node delete dev_all && knife client delete dev_all && sudo rm -rf ~/Dropbox/projects/vine/vine-chef/source_dir/ && rvmsudo vagrant up

clear && knife cookbook upload vine_shared -o cookbooks/ && pushd ~/Dropbox/projects/vine/vine-web && knife cookbook upload vine_web -o cookbooks/&& popd && time rvmsudo vagrant provision

clear && knife cookbook upload vine_ejabberd -o cookbooks/  && time rvmsudo vagrant provision
