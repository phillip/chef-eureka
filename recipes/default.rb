#
# Cookbook Name:: eureka
# Recipe:: server
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

include_recipe "tomcat"

file "/var/lib/tomcat#{node["tomcat"]["base_version"]}/conf/Catalina/localhost/ROOT.xml" do
  action :delete
end

directory "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/ROOT" do
  not_if "test -f /var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka.war"
  action :delete
  recursive true
end

resources(:template => "/etc/tomcat#{node["tomcat"]["base_version"]}/server.xml").instance_exec do
  cookbook "eureka"
end

directory "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka" do
  recursive true
  user "tomcat#{node["tomcat"]["base_version"]}"
  group "tomcat#{node["tomcat"]["base_version"]}"
end

execute "jar -xf ../eureka.war" do
  user "tomcat#{node["tomcat"]["base_version"]}"
  group "tomcat#{node["tomcat"]["base_version"]}"
  cwd "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka"
  action :nothing
end

if node['eureka']['git_id']
  package "git-core"
  
  bash "install_eureka_server" do
    user "root"
    not_if "test -f /var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka.war"
    code <<-EOH
    cd /tmp
    git clone https://github.com/Netflix/eureka.git
    cd eureka
    git checkout #{node['eureka']['git_id']}
    #TODO: put templates in eureka-server/conf
    ./gradlew clean build
    mv target/eureka.war /var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/
    EOH
    notifies :restart, resources(:service => "tomcat")
    notifies :run, resources("execute[jar -xf ../eureka.war]"), :immediately
  end
else
  
  remote_file "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka.war" do
    source node['eureka']['server_url']
    owner "tomcat#{node["tomcat"]["base_version"]}"
    group "tomcat#{node["tomcat"]["base_version"]}"
    # needs to notify to delete the extracted asgard folder before tomcat restart
    notifies :restart, resources(:service => "tomcat")
    notifies :run, resources("execute[jar -xf ../eureka.war]"), :immediately
  end

end

execute "rm -f /var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka/WEB-INF/classes/eureka-*.properties" do
  only_if "test -f /var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka/WEB-INF/classes/eureka-server-test.properties"
end

%w{ client server }.each do |n|
  template "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps/eureka/WEB-INF/classes/eureka-#{n}.properties" do
    source      "eureka-#{n}.properties.erb"
    owner       "tomcat#{node["tomcat"]["base_version"]}"
    group       "tomcat#{node["tomcat"]["base_version"]}"
    mode        '0644'
    variables(:eureka => node['eureka'])
  end
end
