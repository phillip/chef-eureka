default['eureka']['server_url'] = "http://search.maven.org/remotecontent?filepath=com/netflix/eureka/eureka-server/1.1.37/eureka-server-1.1.37.war"
default['eureka']['git_id'] = nil

default['eureka']['wait_time_in_ms_when_sync_empty'] = nil
default['eureka']['registration_enabled'] = true
default['eureka']['aws_access_id'] = ""
default['eureka']['aws_secret_key'] = ""

default['eureka']['datacenter'] = nil
default['eureka']['environment'] = nil
default['eureka']['region'] = "default"
default['eureka']['name'] = "eureka"
default['eureka']['vip_address'] = "eureka.mydomain.com"
default['eureka']['port'] = 80
default['eureka']['prefer_same_zone'] = false

default['eureka']['availability_zones'] = []
default['eureka']['service_url'] = {}

default['eureka']['should_use_dns'] = false
default['eureka']['domain_name'] = "mydomaintest.netflix.net"
default['eureka']['context'] = "eureka/v2"

default['eureka']['home_page_url'] = nil
default['eureka']['home_page_url_path'] = nil
default['eureka']['health_check_url'] = nil
default['eureka']['health_check_url_path'] = nil
default['eureka']['status_page_url'] = nil
default['eureka']['status_page_url_path'] = nil

default[:eureka][:http_proxy][:variant] = "nginx"
default[:eureka][:http_proxy][:port] = node['eureka']['port']
default[:eureka][:http_proxy][:client_max_body_size] = "1024m"
