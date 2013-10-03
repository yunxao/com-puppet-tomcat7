class tomcat7::service() {
  $tomcat_service_action = "${tomcat7::params::tomcat_service_action}"
  $tomcat_service_name   = "${tomcat7::params::tomcat_service_name}"

  service {"${tomcat_service_name}" :
    name   => "${tomcat_service_name}",
    ensure => true
  }
}
