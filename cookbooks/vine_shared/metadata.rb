maintainer       "Vine.IM"
maintainer_email "lehrburger@gmail.com"
license          "All rights reserved"
description      "Installs/Configures vine_shared"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.4"

#NOTE using specific versions so that I can stay aware of changes in upstream cookbooks
depends "mysql", "= 2.1.0"
depends "database", "= 1.3.10"
depends "nginx", "= 1.1.2"
depends "supervisor", "= 0.4.0"
depends "vine_ejabberd", ">= 0.1.0"
