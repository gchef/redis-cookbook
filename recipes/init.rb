case node[:redis][:init]
when "init"
  template "/etc/init.d/redis" do
    source "redis.sysv.erb"
    mode 0755
    backup false
    notifies :restart, "service[redis]"
  end
when "upstart"
  template "/etc/init/redis.conf" do
    source "redis.upstart.erb"
    mode 0644
    backup false
    notifies :restart, "service[redis]"
  end
end

service "redis" do
  supports :start => true, :stop => true, :restart => true
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart if node[:redis][:init] == "upstart"
end
