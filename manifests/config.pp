# Private class.
class rsh::config {

  #rsh::rhosts { '/etc/hosts.equiv': }

  concat { '/etc/hosts.equiv':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat { '/root/.rhosts':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # Template uses:
  # - $nodes
  concat::fragment { '/etc/hosts.equiv-header':
    target  => '/etc/hosts.equiv',
    content => template('rsh/hosts.equiv.erb'),
    order   => '01',
  }

  # Template uses:
  # - $root_nodes
  concat::fragment { '/root/.rhosts-header':
    target  => '/root/.rhosts',
    content => template('rsh/root-rhosts.erb'),
    order   => '01',
  }

  if $rsh::update_securetty {
    if 'rsh' in $rsh::securettys {
      $_rsh_securetty_ensure = 'present'
    } else {
      $_rsh_securetty_ensure = 'absent'
    }
    if 'rlogin' in $rsh::securettys {
      $_rlogin_securetty_ensure = 'present'
    } else {
      $_rlogin_securetty_ensure = 'absent'
    }
    if 'rexec' in $rsh::securettys {
      $_rexec_securetty_ensure = 'present'
    } else {
      $_rexec_securetty_ensure = 'absent'
    }

    file_line { 'securetty-rsh':
      ensure => $_rsh_securetty_ensure,
      path   => '/etc/securetty',
      line   => 'rsh',
    }
    file_line { 'securetty-rlogin':
      ensure => $_rlogin_securetty_ensure,
      path   => '/etc/securetty',
      line   => 'rlogin',
    }
    file_line { 'securetty-rexec':
      ensure => $_rexec_securetty_ensure,
      path   => '/etc/securetty',
      line   => 'rexec',
    }
  }

}
