maintainer       "Vine.IM"
maintainer_email "lehrburger@gmail.com"
license          "All rights reserved"
description      "Installs/Configures vine_shared"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

#NOTE using specific versions so that I can stay aware of changes in upstream cookbooks
depends "mysql", "= 2.1.0"
depends "database", "= 1.3.9"  #NOTE this is my local version bump of the database cookbook because of http://tickets.opscode.com/browse/COOK-2117
depends "nginx", "= 1.1.2"
depends "vine_ejabberd", "~> 0.1.0"
depends "deploy_wrapper", "= 0.0.2"
