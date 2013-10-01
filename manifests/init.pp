class tomcat7 (
  $catalina_home = "",
  $java_home = "") 
  {


  $java_homer = hiera ('java_home') 

  include tomcat7::params 

#  notify { "${tomcat7::params::service_path}": }
  notify { "java_home": 
    message => $java_homer
  }
#  notify { "feo": }
}


