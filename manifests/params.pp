# jre_install module
# install.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid

# The params is obtained in this class. The explain of each param is done in the common.yaml
class jre_install::params () {
  $jre_package            = hiera('jre_package')
  $jre_filename           = hiera('jre_filename')
  $installation_path      = hiera('installation_path')
  $installation_directory = hiera('installation_directory')
  $java_home              = hiera('java_home')
  $tmp_dir                = hiera('tmp_dir')
  $tar_command            = hiera('tar_command')
  $persistent_dir         = hiera('persistent_dir')
}
