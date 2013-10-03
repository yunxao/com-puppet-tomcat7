define tomcat7::create_dir ($path, $owner, $group) {
  $a1 = split ($path,'/')
  each($a1) |$value| {
    if $value != "" {
      
      $a2 = split($path,"$value")
      $reqdir = $a2[0]
      $dir = "${reqdir}${value}/"
#       notify {"-$value-" : 
#          message => "$reqdir | $dir | $value "
#       }
      if $reqdir == '/' {
         file { "$dir": 
            ensure => directory, 
         }
      } elsif $dir == "${path}/" {
         file { "$dir": 
            ensure  => directory,
            owner   => "$owner", 
            group   => "$group", 
            require => File["$reqdir"], 
         }

      } else {
         file { "$dir": 
            ensure => directory,
            require => File["$reqdir"], 
         }
      }
    }
  }

}

class tomcat7::install {
  
#  include tomcat7::params
#  notify {"--${tomcat7::params::tomcat_user}--":}
#  notify {"--${tomcat7::params::tomcat_service_name}":}
#  notify {"--${tomcat7::params::tomcat_security}":}
  $template_file      = "${tomcat7::params::template_file}"
  $in_service_name    = "${tomcat7::params::tomcat_service_name}"
  $in_service_path    = "${tomcat7::params::service_path}"
  $in_java_home       = "${tomcat7::params::java_home}"
  $in_java_opts       = "${tomcat7::params::java_opts}"
  $in_catalina_base   = "${tomcat7::params::catalina_base}"
  $in_catalina_home   = "${tomcat7::params::catalina_home}"
  $in_tomcat_security = "${tomcat7::params::tomcat_security}"
  $in_tomcat_user     = "${tomcat7::params::tomcat_user}"
  $in_tomcat_group    = "${tomcat7::params::tomcat_group}"
  $in_tomcat_package  = "${tomcat7::params::tomcat_package}"
  $in_tomcat_filename = "${tomcat7::params::tomcat_filename}"
  $in_tmp_dir         = "${tomcat7::params::tmp_dir}"
  $in_tar_command     = "${tomcat7::params::tar_command}"
  
  # check if tar is defined
  if ! defined(Package['tar']) {
    package { 'tar':
      ensure => installed,
    }
  }


  
  
  file  { 'tomcat_service' : 
    ensure   => file,
    path     => "${in_service_path}/${in_service_name}", 
    owner    => root, 
    group    => root, 
    mode     => 755, 
    content  => template('tomcat7/tomcat7-service.erb') ,
  }
  tomcat7::create_dir {'catalina_home_1' : 
    path  => "$in_catalina_home", 
    owner => "$in_tomcat_user",
    group => "$in_tomcat_group", 
  }
  file { "${in_tomcat_filename}" : 
    ensure   => file, 
    path     => "${in_tmp_dir}/${in_tomcat_filename}", 
    owner    => "$in_tomcat_user",
    group    => "$in_tomcat_group",
    source   => "puppet:///modules/tomcat7/${in_tomcat_filename}",  
  }

   # zip file of tomcat has the directory inside and is needed to remove it
   exec { "uncompress tomcat":
         cwd     => "${in_catalina_home}",
         command => "${in_tar_command} xzvf /tmp/${in_tomcat_filename} --xform='s,${in_tomcat_package},.,'",
         require => [ Package["tar"], File["${in_tomcat_filename}"], Tomcat7::Create_dir['catalina_home_1']] ,
   }

   

#  file {'catalina_home_2' : 
#    ensure  => directory, 
#    path    => "$in_catalina_home",
#    owner   => "puppet", 
#    group   => "puppet", 
#    require => Tomcat7::Create_dir ['catalina_home_1']
#  }
#  my_create_directory("$in_catalina_home")
#  fun()

#  $e = $array[1]
#  notify {"$e":}
#  file { split($in_catalina_home, '//'): 
#    ensure  => directory, 
#  }

#  file {'catalina_home': 
#    ensure   => directory,
#    recurse => true,
#    path     => "${in_catalina_home}", 
#    owner    => "${in_tomcat_user}", 
#    group    => "${in_tomcat_group}", 
#    mode     => 755, 
#  }

}
