#
define rsh::rhost (
  $host   = $name,
  $user   = '',
  $target = '/etc/hosts.equiv',
  $order  = '10',
) {

  concat::fragment { "rsh::rhost-${name}":
    target  => $target,
    content => "${host} ${user}\n",
    order   => $order,
  }

}
