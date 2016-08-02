# See README.md for more details.
class rsh (
  $package_ensure         = 'present',
  $package_name           = $rsh::params::package_name,
  $service_ensure         = 'running',
  $service_enable         = true,
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

  $_rsh_service_ensure    = pick($rsh_service_ensure, $service_ensure)
  $_rsh_service_enable    = pick($rsh_service_enable, $service_enable)
  $_rlogin_service_ensure = pick($rlogin_service_ensure, $service_ensure)
  $_rlogin_service_enable = pick($rlogin_service_enable, $service_enable)
  $_rexec_service_ensure  = pick($rexec_service_ensure, $service_ensure)
  $_rexec_service_enable  = pick($rexec_service_enable, $service_enable)

  contain 'rsh::install'
  contain 'rsh::config'
  contain 'rsh::service'

  Class['rsh::install']->
  Class['rsh::config']->
  Class['rsh::service']

}
