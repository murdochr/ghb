class varnish::firewall {
    firewall { '500 varnish':
        action  => 'accept',
        dport   => '80',
        require => Class['varnish::package'],
    }
}
