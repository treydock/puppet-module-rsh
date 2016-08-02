# Private class.
class rsh::params {

  case $::osfamily {
    'RedHat': {
      $package_name         = 'rsh-server'
      $client_package_name  = 'rsh'
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $service_class = 'redhat7'
      } else {
        $service_class = 'redhat6'
      }
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
