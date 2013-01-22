maintainer       "Phillip Goldenburg"
maintainer_email "phillip.goldenburg@sailpoint.com"
license          "Apache 2.0"
description      "Installs/Configures eureka"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ tomcat }.each do |cb|
  depends cb
end