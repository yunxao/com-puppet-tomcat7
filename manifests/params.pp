# jre_install module
# install.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid


class jre_install::params () {
  $jre_package            = hiera('jre_package')
  $jre_filename           = hiera('jre_filename')
  $installation_path      = hiera('installation_path')
  $installation_directory = hiera('installation_directory')
  $tmp_dir                = hiera('tmp_dir')
  $tar_command            = hiera('tar_command')
}
