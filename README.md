Description
===========

Installs and configures Netflix Eureka.

Requirements
============

Tested Platforms:

* Ubuntu (Oracle)

The following Opscode cookbooks are dependencies:

* java
* tomcat

Attributes
==========

* `default['eureka']['server_url']` - The location to install Eureka from
* `default['eureka']['git_id']` - Optionally install from git repository
* `default['eureka']['wait_time_in_ms_when_sync_empty']`
* `default['eureka']['aws_access_id']` - The AWS Access Key that eureka will use
* `default['eureka']['aws_secret_key']` - The AWS Secret Key that eureka will use
* `default['eureka']['datacenter']`
* `default['eureka']['environment']`
* `default['eureka']['region']`
* `default['eureka']['name']`
* `default['eureka']['vip_address']`
* `default['eureka']['port']`
* `default['eureka']['prefer_same_zone']`
* `default['eureka']['availability_zones']`
* `default['eureka']['service_url']`
* `default['eureka']['should_use_dns']`
* `default['eureka']['domain_name']`
* `default['eureka']['context']`
* `default['eureka']['home_page_url']`
* `default['eureka']['home_page_url_path']`
* `default['eureka']['health_check_url']`
* `default['eureka']['health_check_url_path']`
* `default['eureka']['status_page_url']`
* `default['eureka']['status_page_url_path']`

Usage
=====

Simply include the recipe where you want Eureka installed.

License and Author
==================

Author:: Phillip Goldenburg (<phillip.goldenburg@sailpoint.com>)

Copyright 2012, Phillip Goldenburg

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
