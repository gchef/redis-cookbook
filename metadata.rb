maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Installs and configures Redis 2.4.8"
version           "2.0.2"

recipe "redis::source", "Installs redis from source"
recipe "redis::master", "Installs redis from source and configures it as a master instance"
recipe "redis::slave", "Installs redis from source and configures it as a slave instance"

supports "ubuntu"
supports "debian"

depends "build-essential"
