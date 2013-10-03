class tomcat7::deploy {
  $at = "${tomcat7::params::array_token}"
  #an array cannot be copy, it can be join and then split
  $wars = split("${tomcat7::params::deploy_wars}", "$at")
  $tomcat_user     = "${tomcat7::params::tomcat_user}"
  $tomcat_group    = "${tomcat7::params::tomcat_group}"
  $catalina_webdir = "${tomcat7::params::catalina_webdir}" 
  
    
  each ($wars) |$war| {
    file {  $war: 
      path     => "${catalina_webdir}/${war}",
      ensure   => file,
      owner    => "${tomcat_user}", 
      group    => "${tomcat_group}", 
      source   => "puppet:///modules/tomcat7/${war}", 
    } 
  }
#  each (${tomcat7::params::wars}) |$value| {
#    notify { "$value" :}
#  } 

}
