class varnish::service {
    service { 'varnish':
        subscribe   => Class['varnish::package'],
        require     => Class['varnish::config'],
    }
}
