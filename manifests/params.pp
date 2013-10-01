class tomcat7::params {
  $service_path = hiera('service_path')
  $tomcat_service_name = hiera('tomcat_service_name')
  $tomcat_package = hiera('tomcat_package')
  $information = hiera('tmp')
  $JAVA_HOME = "" 
  $CATALINA_HOME = "" 

#  notify{$service_path : }
}
