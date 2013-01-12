Useful Commands
===============
```sh
rvmsudo vagrant destroy && \
knife node delete dev_all && knife client delete dev_all && \
sudo rm -rf ~/Dropbox/projects/vine/vine-chef/source_dir/ && \
time sh upload_all.sh && time rvmsudo vagrant up


clear && knife cookbook upload vine_shared -o cookbooks/ && pushd ~/Dropbox/projects/vine/vine-web && knife cookbook upload vine_web -o cookbooks/&& popd && time rvmsudo vagrant provision

clear && knife cookbook upload vine_ejabberd -o cookbooks/  && time rvmsudo vagrant provision

knife data bag from file dev config.json --secret-file /Volumes/secret_keys/data_bags/dev_key
knife data bag show dev config       -Fj --secret-file /Volumes/secret_keys/data_bags/dev_key > data_bags/dev/config.json

knife data bag edit prod config --secret-file /Volumes/secret_keys/data_bags/prod_key
knife data bag show prod config -Fj > data_bags/prod/config.json

knife node delete prod_ejabberd && \
knife client delete prod_ejabberd && \
knife ec2 server create \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --image             ami-3d4ff254 \
  --ssh-user          ubuntu \
  --flavor            m1.small \
  --groups            vine-ejabberd\
  --run-list          role[ejabberd] \
  --node-name         prod_ejabberd \
  --server-url        https://api.opscode.com/organizations/vine \
  --environment       prod \
  --ssh-key           vine-ejabberd-key \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/vine-ejabberd-key.pem \
  --availability-zone us-east-1b \
  --bootstrap-version 10.16.4 \
  --ebs-no-delete-on-term

ssh -i /Volumes/secret_keys/aws_key_pairs/vine-ejabberd-key.pem ubuntu@IPADDRESS

knife ssh name:prod_ejabberd \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --server-url        https://api.opscode.com/organizations/vine \
  --key               /Volumes/secret_keys/lehrblogger.pem \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/vine-ejabberd-key.pem \
  --ssh-user          ubuntu \
  "sudo chef-client"
```
