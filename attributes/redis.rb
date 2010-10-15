default[:redis][:version]   = "1.2.6"
default[:redis][:source]    = "http://redis.googlecode.com/files/redis-#{redis[:version]}.tar.gz"
default[:redis][:checksum]  = "c71aef0b3f31acb66353d86ba57dd321b541043f"
default[:redis][:bins]      = %w(redis-benchmark redis-cli redis-server redis-stat)

default[:redis][:dir]       = "/opt/redis-#{redis[:version]}"
default[:redis][:datadir]   = "/var/db/redis"
default[:redis][:config]    = "/etc/redis.conf"
default[:redis][:logfile]   = "/var/log/redis.log"
default[:redis][:pidfile]   = "/var/run/redis.pid"

default[:redis][:port]        = 6379
default[:redis][:timeout]     = 300
default[:redis][:databases]   = 16
default[:redis][:max_memory]  = 256
default[:redis][:snapshots]   = {
  900 => 1,
  300 => 10,
  60  => 10000
}
default[:redis][:dbfilename]   = "redis_state.rdb"
default[:redis][:bind_address]= "0.0.0.0"
default[:redis][:loglevel]    = "notice"
