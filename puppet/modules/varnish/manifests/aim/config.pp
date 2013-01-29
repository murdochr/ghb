# Class: varnish::aim::config
#
# Configure the AIM VCL (and library) for use in Varnish. Most changes trigger
# a reload rather than a restart. The exceptions to this are sysconfig changes
# which obviously require a daemon restart and "aim.conf" which doesn't appear
# to be re-sourced by libaim between reloads.
#
class varnish::aim::config inherits varnish::config {
    $varnish_aim_db_host    = extlookup('varnish_aim_db_host')
    $varnish_aim_db_db      = extlookup('varnish_aim_db_db', 'sso')
    $varnish_aim_db_user    = extlookup('varnish_aim_db_user', 'sso_user')
    $varnish_aim_db_pass    = extlookup('varnish_aim_db_pass')

    File['/etc/sysconfig/varnish'] {
        source  => 'puppet:///modules/varnish/etc/sysconfig/varnish.aim',
    }
    file {
        '/etc/varnish/aim.conf':
            mode    => '0640',
            group   => 'varnish',
            content => template('varnish/etc/varnish/aim.conf.erb'),
            notify  => Class['varnish::service'];
        '/etc/varnish/aim/error.vcl':
            ensure  => link,
            target  => '../conf.d/error.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/aim/hash.vcl':
            ensure  => link,
            target  => '../conf.d/hash.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/aim/backend.vcl':
            ensure  => link,
            target  => '../conf.d/backend.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/aim/recv.vcl':
            ensure  => link,
            target  => '../conf.d/recv.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/aim/fetch.vcl':
            ensure  => link,
            target  => '../conf.d/fetch.vcl',
            notify  => Class['varnish::reload'];
    }
}
