class tomcat7 (
  $catalina_home = "",
  $java_home = "") 
  {


  $information = hiera ('service_path') 

  include tomcat7::params 
  include tomcat7::install

#  notify { "${tomcat7::params::tomcat_package}": }
#  notify { "-${tomcat7::params::service_path}": }
#  notify { "java_home": 
#    message => $information
#  }
#  notify { "feo": }
}


