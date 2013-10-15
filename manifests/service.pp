# tomcat7 module
# service.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid
class tomcat7::service() {
  include tomcat7::params
  $tomcat_service_action = "${tomcat7::params::tomcat_service_action}"
  $tomcat_service_name   = "${tomcat7::params::tomcat_service_name}"
  $service_path          = "${tomcat7::params::service_path}"
#  notify {"---${tomcat_service_name} ${tomcat_service_action}---" : }
#   file {"${service_path}/${tomcat_service_name}" : 
#      path     => "${service_path}/${tomcat_service_name}",
#      notify   => Service['tomcat7'], 
#  }
#  service {"tomcat7" :
#    binary => "${service_path}/${tomcat_service_name}",
#    enable => true, 
#    ensure => "running", 
#    start  => ' start', 
#  }

  exec {"service_start" : 
    cwd     => "${service_path}", 
    command => "${service_path}/${tomcat_service_name} ${tomcat_service_action}", 
  }
#  service {"${tomcat_service_name}" :
#    name   => "${tomcat_service_name}",
#    ensure => running,
#  }
}
