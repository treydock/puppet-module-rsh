#
class rsh::service::redhat7 {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'rsh':
    ensure => $rsh::_rsh_service_ensure,
    enable => $rsh::_rsh_service_enable,
    name   => 'rsh.socket'
  }

  service { 'rlogin':
    ensure => $rsh::_rlogin_service_ensure,
    enable => $rsh::_rlogin_service_enable,
    name   => 'rlogin.socket'
  }

  service { 'rexec':
    ensure => $rsh::_rexec_service_ensure,
    enable => $rsh::_rexec_service_enable,
    name   => 'rexec.socket'
  }

}
