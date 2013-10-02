class tomcat7::install {
  
#  include tomcat7::params
#  notify {"--${tomcat7::params::tomcat_service_name}":}
  $in_service_name    = "${tomcat7::params::tomcat_service_name}"
  $in_service_path    = "${tomcat7::params::service_path}"
  $in_java_home       = "${tomcat7::params::java_home}"
  $in_java_user       = "${tomcat7::params::java_user}"
  $in_java_group      = "${tomcat7::params::java_group}"
  $in_java_opts       = "${tomcat7::params::java_opts}"
  $in_catalina_base   = "${tomcat7::params::catalina_base}"
  $in_catalina_home   = "${tomcat7::params::catalina_home}"
  $in_tomcat_security = "${tomcat7::params::tomcat_security}"

  
  
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
