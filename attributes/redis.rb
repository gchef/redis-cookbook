default[:redis][:version]   = "2.0.4"
default[:redis][:checksum]  = "fee2f1960eda22385503517a9a6dcae610df84d5"
default[:redis][:source]    = "http://redis.googlecode.com/files/redis-#{redis[:version]}.tar.gz"


default[:redis][:bins]      = %w(redis-benchmark redis-cli redis-server mkreleasehdr.sh redis-check-aof redis-check-dump)

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

default[:redis][:master]      = false
default[:redis][:slaveof]     = nil
default[:redis][:password]    = nil
