class varnish::reload {
    exec { '/sbin/service varnish reload':
        refreshonly => true,
        require     => Class['varnish::service'],
    }
}
