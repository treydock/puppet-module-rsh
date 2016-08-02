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

}
