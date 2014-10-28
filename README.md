Incomplete Checklist for Refreshing Security
===============

 - Copy down a dump.erl file from the first ejabberd
 - Make a new folder in vine_secrets and update knife.rb both there and in ~.
 - Get a new SSL certificate.
 - Generate new keys for the data bags with `openssl rand -base64 512 | tr -d '\r\n'`
 - Generate new deploy keys for both vine_web and vine_xmpp, put them in GitHub, encrypt them with the keys above, put them in the data bags.
 - Get a new aws_key_pair, and either delete the old one (forever!) or update the places where it's specified.
 - Regenerate the organization and user .pems on the Chef website
 - Change all of the passwords in the main databag (including API keys from other services)
 - Deploy the server. NOTE, run `sudo apt-get -q -y install rsyslog-gnutls` while ejabberd or something is compiling, otherwise papertrail will fail right before the end! TODO: put this in a recipe.
 - Run `sudo apt-get upgrade all` to update the packages.
 - Copy up the dump from the othe machine and run `sudo ejabberdctl load /home/ubuntu/ejabberd_dump_cutover.erl` (possibly after modifying permissions).
 - Start ejabberd with `sudo ejabberdctl start`
 - Reassociate the elastic IP
 - Briefly change IAM policy to let Celery create another SQS queue, grab the ARN, and then update the policy accordingly and delete the old queue. Otherwise papertrail will fill up with logs!
 - Change over CloudWatch alerts
 - Test everything!

All of this will take at least 3-4 hours, and that's assuming Chef hasn't broken anything with random version updates, which it probably has. Starting up a fresh server alone takes at least 25 minutes :-/


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
  --identity-file     /Volumes/secret_keys/post-shellshock/aws_key_pairs/dashdash-consolidated.pem \
  --availability-zone us-east-1b \
  --bootstrap-version 10.32.2 \
  --ebs-no-delete-on-term
```

