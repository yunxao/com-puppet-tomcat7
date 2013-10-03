class jre-manual-install::params () {
  $jre_package            = hiera('jre_package')
  $jre_filename           = hiera('jre_filename')
  $installation_path      = hiera('installation_path')
  $installation_directory = hiera('installation_directory')


}
