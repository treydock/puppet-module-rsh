#
class rsh::service::redhat6 {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # NOT YET IMPLEMENTED 

}
