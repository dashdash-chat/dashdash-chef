Dev Commands
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

# To make a new hashed supervisor password:
echo -n password | shasum -a 1 | awk '{print $1}'
```

MySQL querues
===============
```sql
# New users
SELECT id, name, twitter_id, email, stage, created FROM users WHERE is_active = 1 AND created > '2013-04-22 00:00:00' ORDER BY created ASC;

# Active conversations with participants
SELECT p.vinebot_id, GROUP_CONCAT(users.name SEPARATOR ', ') AS participants FROM participants AS p INNER JOIN users ON p.user_id = users.id GROUP BY p.vinebot_id;
```

Deploy Commands
===============
```sh
ssh -i /Volumes/secret_keys/aws_key_pairs/dashdash-consolidated.pem ubuntu@54.83.7.191

knife ssh name:prod_SERVER \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --server-url        https://api.opscode.com/organizations/dashdash \
  --key               /Volumes/secret_keys/lehrblogger.pem \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/dashdash-SERVER.pem \
  --ssh-user          ubuntu \
  "COMMAND"

time sh upload_all.sh && \
knife node delete prod_consolidated && \
knife client delete prod_consolidated && \
knife ec2 server create \
  --config            /Volumes/secret_keys/knife-ec2.rb \
  --image             ami-59a4a230 \
  --ssh-user          ubuntu \
  --flavor            m1.small \
  --groups            dashdash-consolidated \
  --run-list          "'role[consolidated]'" \
  --node-name         prod_consolidated \
  --server-url        https://api.opscode.com/organizations/dashdash \
  --environment       prod \
  --ssh-key           dashdash-consolidated \
  --identity-file     /Volumes/secret_keys/aws_key_pairs/dashdash-consolidated.pem \
  --availability-zone us-east-1b \
  --bootstrap-version 10.32.2 \
  --ebs-no-delete-on-term
```

