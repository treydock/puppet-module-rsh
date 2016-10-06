# See README.md for more details.
class rsh (
  $ensure                 = 'present',
  $package_ensure         = undef,
  $package_name           = $rsh::params::package_name,
  $service_ensure         = undef,
  $service_enable         = undef,
  $rsh_service_ensure     = undef,
  $rsh_service_enable     = undef,
  $rlogin_service_ensure  = undef,
  $rlogin_service_enable  = undef,
  $rexec_service_ensure   = undef,
  $rexec_service_enable   = undef,
  $nodes                  = [],
  $root_nodes             = [],
  $update_securetty       = true,
  $securettys             = ['rlogin', 'rsh'],
) inherits rsh::params {

  validate_bool($update_securetty)
  validate_array($nodes)
  validate_array($root_nodes)
  validate_array($securettys)

  case $ensure {
    'present': {
      $_package_ensure_default = 'present'
      $_service_ensure_default = 'running'
      $_service_enable_default = true
    }
    'absent': {
      $_package_ensure_default = 'absent'
      $_service_ensure_default = 'stopped'
      $_service_enable_default = false
    }
    default: {
      fail("${module_name} ensure must be present or absent, ${ensure} given.")
    }
  }

  $_package_ensure        = pick($package_ensure, $_package_ensure_default)
  $_service_ensure        = pick($service_ensure, $_service_ensure_default)
  $_service_enable        = pick($service_enable, $_service_enable_default)
  $_rsh_service_ensure    = pick($rsh_service_ensure, $_service_ensure)
  $_rsh_service_enable    = pick($rsh_service_enable, $_service_enable)
  $_rlogin_service_ensure = pick($rlogin_service_ensure, $_service_ensure)
  $_rlogin_service_enable = pick($rlogin_service_enable, $_service_enable)
  $_rexec_service_ensure  = pick($rexec_service_ensure, $_service_ensure)
  $_rexec_service_enable  = pick($rexec_service_enable, $_service_enable)

  contain 'rsh::install'
  contain 'rsh::config'
  contain 'rsh::service'

  if $ensure == 'present' {
    Class['rsh::install']->
    Class['rsh::config']->
    Class['rsh::service']
  } elsif $ensure == 'absent' {
    Class['rsh::service']->
    Class['rsh::config']->
    Class['rsh::install']
  }

}
