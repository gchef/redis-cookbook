default[:redis][:version]   = "2.4.2"
default[:redis][:checksum]  = "f04e2a1ec26098e4046a8687d3611b473e81a2e5f7dc539a0a82715714054f6e"
default[:redis][:source]    = "http://redis.googlecode.com/files/redis-#{redis[:version]}.tar.gz"

default[:redis][:datadir]   = "/var/db/redis"
default[:redis][:config]    = "/etc/redis.conf"
default[:redis][:logfile]   = "/var/log/redis.log"
default[:redis][:pidfile]   = "/var/run/redis.pid"
default[:redis][:init]      = "upstart"

default[:redis][:port]        = 6379
default[:redis][:timeout]     = 300
default[:redis][:databases]   = 16
default[:redis][:maxmemory]   = 0
default[:redis][:snapshots]   = {
  900 => 1,
  300 => 10,
  60  => 10000
}

default[:redis][:dbfilename]                = "redis_state.rdb"
default[:redis][:rdbcompression]            = "yes"
default[:redis][:bind_address]              = "0.0.0.0"
default[:redis][:unixsocket]                = false
default[:redis][:loglevel]                  = "notice"

default[:redis][:syslog_enabled]            = "no"
default[:redis][:syslog_ident]              = "redis"
default[:redis][:syslog_facility]           = "local0"

default[:redis][:slaveof]                   = false
default[:redis][:password]                  = false
default[:redis][:slave_serve_stale_data]    = "yes"

default[:redis][:maxmemory_policy]          = "volatile-lru"
default[:redis][:maxmemory_samples]         = 3

default[:redis][:appendonly]                = "no"
default[:redis][:appendfilename]            = "appendonly.aof"
default[:redis][:appendfsync]               = "everysec"
default[:redis][:no_appendfsync_on_rewrite] = "no"

default[:redis][:command_renames]           = {}

default[:redis][:vm_enabled]                = "no"
default[:redis][:vm_swap_file]              = "/tmp/redis.swap"
default[:redis][:vm_max_memory]             = 0
default[:redis][:vm_page_size]              = 32
default[:redis][:vm_pages]                  = 134217728
default[:redis][:vm_max_threads]            = 4

default[:redis][:hash_max_zipmap_entries]   = 512
default[:redis][:hash_max_zipmap_value]     = 64
default[:redis][:list_max_ziplist_entries]  = 512
default[:redis][:list_max_ziplist_value]    = 64
default[:redis][:set_max_intset_entries]    = 512
default[:redis][:activerehashing]           = "yes"
