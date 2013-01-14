Useful Dev Commands
===============
```sh
rvmsudo vagrant destroy && \
knife node delete dev_all_vm2 && knife client delete dev_all_vm2 && \
sudo rm -rf ~/Dropbox/projects/vine/vine-chef/source_dir/ && \
time sh upload_all.sh && time rvmsudo vagrant up

time sh upload_all.sh && time rvmsudo vagrant provision

knife data bag from file dev config.json --secret-file /Volumes/secret_keys/data_bags/dev_key
knife data bag show dev config       -Fj --secret-file /Volumes/secret_keys/data_bags/dev_key > data_bags/dev/config.json

knife data bag edit prod config --secret-file /Volumes/secret_keys/data_bags/prod_key
knife data bag show prod config -Fj > data_bags/prod/config.json

```
Useful Deploy Commands
===============
```sh
ssh -i /Volumes/secret_keys/aws_key_pairs/vine-ejabberd-key.pem ubuntu@107.21.218.247
ssh -i /Volumes/secret_keys/aws_key_pairs/vine-leaves-key.pem ubuntu@54.235.240.250
ssh -i /Volumes/secret_keys/aws_key_pairs/vine-web-key.pem ubuntu@184.72.244.2

knife ssh name:prod_SERVER \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --server-url        https://api.opscode.com/organizations/vine \
  --key               /Volumes/secret_keys/lehrblogger.pem \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/vine-SERVER-key.pem \
  --ssh-user          ubuntu \
  "COMMAND"

time sh upload_all.sh && \
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

time sh upload_all.sh && \
knife node delete prod_leaves && \
knife client delete prod_leaves && \
knife ec2 server create \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --image             ami-3d4ff254 \
  --ssh-user          ubuntu \
  --flavor            m1.small \
  --groups            vine-leaves\
  --run-list          role[xmpp] \
  --node-name         prod_leaves \
  --server-url        https://api.opscode.com/organizations/vine \
  --environment       prod \
  --ssh-key           vine-leaves-key \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/vine-leaves-key.pem \
  --availability-zone us-east-1b \
  --bootstrap-version 10.16.4 \
  --ebs-no-delete-on-term

time sh upload_all.sh && \
knife node delete prod_web && \
knife client delete prod_web && \
knife ec2 server create \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --image             ami-3d4ff254 \
  --ssh-user          ubuntu \
  --flavor            t1.small \
  --groups            vine-web\
  --run-list          role[web] \
  --node-name         prod_web \
  --server-url        https://api.opscode.com/organizations/vine \
  --environment       prod \
  --ssh-key           vine-web-key \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/vine-web-key.pem \
  --availability-zone us-east-1b \
  --bootstrap-version 10.16.4 \
  --ebs-no-delete-on-term

```

