# jre_install module
# install.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid



#
# This macro create a directory structure, the last directory, he owner of the last directory is the passed by the parameters
define jre_install::create_dir ($path, $owner, $group) {
  $a1 = split ($path,'/')
  each($a1) |$value| {
    #split all directories
    if $value != "" {
      #catch the previous structure
      $a2 = split($path,"$value")
      $reqdir = $a2[0]
      $dir = "${reqdir}${value}/"
      # the previus is the root there is not require. The directory is defined but there is not changes in this 
      if $reqdir == '/' {
         file { "$dir":
            ensure => directory,
         }
      } 
      # This is the last directory, this is special because there must be defined the owner and the group
      elsif $dir == "${path}/" {
         file { "$dir":
            ensure  => directory,
            owner   => "$owner",
            group   => "$group",
            require => File["$reqdir"],
         }
      } 
      # These thirectories are in the middle, they are defined if they are not exist and require the previous. 
      # The owner an group are root always
      else {
         file { "$dir":
            ensure => directory,
            require => File["$reqdir"],
         }
      }
    }
  }
}


# This is a alternate method to create a directory, This method creates a directory using a local script. 
define jre_install::mkdir ($dir) {
  $tmp_dir         = "${jre_install::params::tmp_dir}"
  # The script is specific for each family os and it is in the 
  # template directory. e.g. The name of the scrip for Debian family 
  # (including Ubuntu) is mkdir-Debian.sh.erb
  file { "${tmp_dir}/${module_name}-${title}.sh" :
    mode     => 744,
    owner    => root,
    group    => root,
    content  => template("${module_name}/mkdir-${::osfamily}.sh.erb") ,
  }
  exec { "${tmp_dir}/${module_name}-${title}.sh":
    cwd     => "${tmp_dir}",
    require => File["${tmp_dir}/${module_name}-${title}.sh"],
  }
}


# The main method of the class. This class install jre
class jre_install::install () {
  $jre_filename              = "${jre_install::params::jre_filename}"
  $java_home                 = "${jre_install::params::java_home}"
  $jre_package               = "${jre_install::params::jre_package}"
  $installation_path         = "${jre_install::params::installation_path}"
  $installation_directory    = "${jre_install::params::installation_directory}"
  $tmp_dir                   = "${jre_install::params::tmp_dir}"
  $tar_command               = "${jre_install::params::tar_command}"
  $persistent_dir            = "${jre_install::params::persistent_dir}"
  $mydir                     = "${persistent_dir}/jre_install"

  # defines tar dependence because the script uses this package
  if ! defined(Package['tar']) {
    package { 'tar':
      ensure => installed,
    }
  }
  # creating the java installation dir
  jre_install::create_dir {'java_dir' : 
    path => "${installation_path}",
    owner    => "root",
    group    => "root",
  }
  # creating persistent dir, in this directory is saved the actual version installed and there is not 
  # reinstalation if there are not a new version (if the file is diferent). The comparation is made with
  # md5 algoritm 
  jre_install::mkdir {'persistent_dir' : 
    dir => "$mydir", 
  }

  # Copy a jre tar file. 
  file { "${jre_filename}" : 
    ensure => file, 
    path     => "${mydir}/${jre_filename}",
    owner    => "root",
    group    => "root",
    source   => "puppet:///modules/jre_install/${jre_filename}",
    require  => Jre_install::Mkdir['persistent_dir'], 
  }

  # Copy the script that evalues and upgrades the jre  version. The 
  # upgrade is done if and onlyif the file copied "File[$jre_filename"] is
  # not the same. 
  # The scrip is specific for each OS family (Debian, redhat etc...) 
  file {'bash-file' : 
    ensure   => file, 
    path     => "${mydir}/check-jre-version.sh",
    content => template("${module_name}/${osfamily}-checkversion.sh.erb"),
    mode    => 775,
    owner   => "root",
    group   => "root",
    require => File["${jre_filename}"], 
  }
  
  # Exec the script to evaluate
  exec {"${mydir}/check-jre-version.sh" :
    cwd      => "${mydir}",
    require  => File['bash-file'],
  }
}

