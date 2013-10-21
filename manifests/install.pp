# jre_install module
# install.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid

define jre_install::create_dir ($path, $owner, $group) {
  $a1 = split ($path,'/')
  each($a1) |$value| {
    if $value != "" {
      $a2 = split($path,"$value")
      $reqdir = $a2[0]
      $dir = "${reqdir}${value}/"
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


class jre_install::install () {
  $jre_filename              = "${jre_install::params::jre_filename}"
  $java_home                 = "${jre_install::params::java_home}"
  $jre_package               = "${jre_install::params::jre_package}"
  $installation_path         = "${jre_install::params::installation_path}"
  $installation_directory    = "${jre_install::params::installation_directory}"
  $tmp_dir                   = "${jre_install::params::tmp_dir}"
  $tar_command               = "${jre_install::params::tar_command}"
 
  
  if ! defined(Package['tar']) {
    package { 'tar':
      ensure => installed,
    }
  }

  jre_install::create_dir {'java_dir' : 
    path => "${installation_path}",
    owner    => "root",
    group    => "root",
  }
  file { "${jre_filename}" : 
    ensure => file, 
    path     => "${tmp_dir}/${jre_filename}",
    owner    => "root",
    group    => "root",
    source   => "puppet:///modules/jre_install/${jre_filename}",
  }

  file {'bash-file' : 
    ensure   => file, 
    path     => "${tmp_dir}/check-jre-version.sh",
    content => template("${module_name}/${osfamily}-checkversion.sh.erb"),
    mode    => 775,
    owner   => "root",
    group   => "root",
    require => File["${jre_filename}"], 
  }
  exec {"${tmp_dir}/check-jre-version.sh" :
    cwd      => "${tmp_dir}",
    require  => File['bash-file'],
  }


 
  # the xform is used to replace strings
#  exec { "uncompress jre":
#    cwd     => "${installation_path}",
#    command => "${tar_command} xzvf /tmp/${jre_filename} --xform='s,${jre_package},${installation_directory},'",
#    require => [ Package["tar"], File["${jre_filename}"], Jre_install::Create_dir['java_dir']] ,
#   }
}

