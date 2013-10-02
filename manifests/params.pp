class tomcat7::params {
#  $service_path = hiera('service_path')
#  $tomcat_service_name = hiera('tomcat_service_name')
#  $tomcat_package = hiera('tomcat_package')
#  $information = hiera('tmp')
#  $JAVA_HOME = "" 
#  $CATALINA_HOME = "" 
  $template_file        = hiera('template_file')
  $java_home            = hiera('java_home')
  $java_opts            = hiera('java_opts')
  $catalina_base        = hiera('catalina_base')
  $catalina_home        = hiera('catalina_home')
  $tomcat_security      = hiera('tomcat_security')
  $tomcat_user          = hiera('tomcat_user')
  $tomcat_group         = hiera('tomcat_group')
  $tomcat_service_name  = hiera('tomcat_service_name')
  $service_path         = hiera('service_path')
#  notify{$service_path : }
}
