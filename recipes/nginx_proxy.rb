#
# Cookbook Name:: eureka
# Recipe:: proxy_nginx
#
# Copyright 2012, Phillip Goldenburg
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

include_recipe "nginx::source"
include_recipe "eureka"

template "#{node[:nginx][:dir]}/sites-available/eureka.conf" do
  source      "nginx_eureka.conf.erb"
  owner       'root'
  group       'root'
  mode        '0644'
  variables(
    :port     => node[:eureka][:http_proxy][:port],
    :max_upload_size  => node[:eureka][:http_proxy][:client_max_body_size]
  )

  if File.exists?("#{node[:nginx][:dir]}/sites-enabled/eureka.conf")
    notifies  :restart, 'service[nginx]'
  end
end

nginx_site "eureka.conf" do
  if node[:eureka][:http_proxy][:variant] == "nginx"
    enable true
  else
    enable false
  end
end

nginx_site "default" do
  enable false
end

nginx_site "000-default" do
  enable false
end
