#
# Cookbook Name:: redis
# Recipe:: init
#
# Author:: Gerhard Lazu (<gerhard@lazu.co.uk>)
#
# Copyright 2011, Gerhard Lazu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node[:redis][:init]
when "init"
  template "/etc/init.d/redis" do
    cookbook "redis"
    source "redis.sysv.erb"
    mode 0755
    backup false
    notifies :restart, "service[redis]"
  end
when "upstart"
  template "/etc/init/redis.conf" do
    cookbook "redis"
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
