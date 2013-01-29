class varnish::aim::package {
    require ::varnish
    require ::mysql::devel
    require ::yum::repos::internal_el

    package { 'varnish-aim':
        ensure  => latest,
        notify  => Class['varnish::service'],
    }
}
