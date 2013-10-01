class tomcat7::install {
  
#  include tomcat7::params
#  notify {"--${tomcat7::params::tomcat_service_name}":}
  $in_service_name = "${tomcat7::params::tomcat_service_name}"
  $in_service_path = "${tomcat7::params::service_path}"
  file  { 'tomcat_service' : 
    ensure   => file,
    path     => "${in_service_path}/${in_service_name}", 
#    path => "/etc/init.d/tomcat7",
#    name     => "${tomcat7::params::tomcat_service_name}", 
    owner    => root, 
    group    => root, 
    mode     => 755, 
    content  => template('tomcat7/tomcat7-service.erb') ,
  }

}
