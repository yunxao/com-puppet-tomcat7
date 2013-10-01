class tomcat7::params {
  case $osfamily {
#    centos, redhat: {
#      $libxml2_development = 'libxml2-devel'
#    }
    debian: {
      $service_path = '/etc/init.d'
    }
    default: {
      fail("Unrecognized libxml2 development header package name for your O.S. $osfamily")
    }
  }

  $JAVA_HOME = "" 
  $CATALINA_HOME = "" 
}
