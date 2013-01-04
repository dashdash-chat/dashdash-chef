Useful Commands
===============

rvmsudo vagrant destroy && \
knife node delete dev_all && knife client delete dev_all && \
sudo rm -rf ~/Dropbox/projects/vine/vine-chef/source_dir/ && \
sudo rm -rf ~/Dropbox/projects/vine/vine-chef/log_dir/ && \
time sh upload_all.sh && \time rvmsudo vagrant up

clear && knife cookbook upload vine_shared -o cookbooks/ && pushd ~/Dropbox/projects/vine/vine-web && knife cookbook upload vine_web -o cookbooks/&& popd && time rvmsudo vagrant provision

clear && knife cookbook upload vine_ejabberd -o cookbooks/  && time rvmsudo vagrant provision
