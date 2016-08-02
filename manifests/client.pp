#
class rsh::client (
  $package_ensure   = 'present',
  $package_name     = $rsh::params::client_package_name,
) inherits rsh::params {

  package { 'rsh':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
