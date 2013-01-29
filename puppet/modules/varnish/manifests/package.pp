class varnish::package {
    require ::yum::repos::epel

    # Pull package from internal repos if not using EL6 and EPEL6.
    if ($::osfamily == 'redhat' and $::operatingsystemmajrelease == '5') {
        require ::yum::repos::backports_el
    }

    package { 'varnish':
        ensure  => latest,
    }
}
