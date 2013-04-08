maintainer       "Vine.IM"
maintainer_email "lehrburger@gmail.com"
license          "All rights reserved"
description      "Installs/Configures vine_ejabberd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.5"

#NOTE using specific versions so that I can stay aware of changes in upstream cookbooks
depends "erlang", "= 1.1.2"
depends "s3cmd", "= 0.1.1"
depends "zlib", "= 2.0.0"
