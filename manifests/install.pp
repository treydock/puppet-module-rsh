# Private class.
class rsh::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'rsh-server':
    ensure => $rsh::package_ensure,
    name   => $rsh::package_name,
  }

}
