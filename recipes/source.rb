#
# Cookbook Name:: redis
# Recipe:: source
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

unless `redis-server -v 2> /dev/null`.include?(node[:redis][:version])
  # ensuring we have this directory
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

include_recipe "redis::init"
