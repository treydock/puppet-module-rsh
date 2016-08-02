# Private class.
class rsh::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  contain "rsh::service::${rsh::params::service_class}"

}
