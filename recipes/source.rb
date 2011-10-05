include_recipe "build-essential"

user "redis" do
  comment "Redis Administrator"
  system true
  shell "/bin/false"
end

directory node[:redis][:datadir] do
  owner "redis"
  group "redis"
  mode 0755
  recursive true
end

include_recipe "redis::init"

service "redis" do
  supports :start => true, :stop => true, :restart => true
  provider Chef::Provider::Service::Upstart if node[:redis][:init] == "upstart"
end

# download and install a new redis version
#
unless `redis-server -v 2> /dev/null`.include?(node[:redis][:version])

  # stop if a previous redis version has been installed
  #
  service "redis" do
    action :stop
    only_if "[ -e /usr/local/bin/redis-server ]"
  end

  # ensuring we have this directory
  #
  directory "#{node[:redis][:basedir]}/src"

  remote_file "#{node[:redis][:basedir]}/src/redis-#{node[:redis][:version]}.tar.gz" do
    source node[:redis][:source]
    checksum node[:redis][:checksum]
    action :create_if_missing
  end

  bash "Compiling Redis v#{node[:redis][:version]} from source" do
    cwd "#{node[:redis][:basedir]}/src"
    code %{
      tar zxf redis-#{node[:redis][:version]}.tar.gz
      cd redis-#{node[:redis][:version]} && make && make install
    }
  end
end

file node[:redis][:logfile] do
  owner "redis"
  group "redis"
  mode 0644
  action :create_if_missing
  backup false
end

template node[:redis][:config] do
  source "redis.conf.erb"
  owner "redis"
  group "redis"
  mode 0644
  backup false
end

execute "echo 1 > /proc/sys/vm/overcommit_memory" do
  not_if "[ $(cat /proc/sys/vm/overcommit_memory) -eq 1 ]"
end

service "redis" do
  action [:enable, :restart]
end
