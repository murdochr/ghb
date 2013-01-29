# Class: varnish::config
#
# Configure Varnish VCL. Most changes trigger a reload rather than a restart.
# The exceptions to this are sysconfig changes which obviously require a daemon
# restart.
#
class varnish::config {
    require ::varnish::package

    # FIXME Puppet #4549. Workaround an issue where functions aren't
    # autoloaded correctly when called from scope.function_ in templates.
    $versioncmp_preload   = versioncmp(0,1)

    # Use RPM based custom fact or fallback to a safe guess. This may result
    # in the first Puppet run failing to start Varnish and then mopping up
    # on the second run.
    $varnish_version_real = $::varnishversion ? {
        default => $::varnishversion,
        ''      => '2.1.0',
    }

    file {
        '/etc/sysconfig/varnish':
            source  => 'puppet:///modules/varnish/etc/sysconfig/varnish',
            notify  => Class['varnish::service'];
        '/etc/varnish/conf.d':
            ensure  => directory;
        '/etc/varnish/default.vcl':
            source  => 'puppet:///modules/varnish/etc/varnish/default.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/conf.d/error.vcl':
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/error.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/conf.d/error_default.vcl':
            content => template('varnish/etc/varnish/conf.d/error_default.vcl.erb'),
            notify  => Class['varnish::reload'];
        '/etc/varnish/conf.d/hash.vcl':
            content => template('varnish/etc/varnish/conf.d/hash.vcl.erb'),
            notify  => Class['varnish::reload'];
        '/etc/varnish/conf.d/recv_headers.vcl':
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/recv_headers.vcl',
            notify  => Class['varnish::reload'];
        '/etc/varnish/conf.d/fetch_headers.vcl':
            content => template('varnish/etc/varnish/conf.d/fetch_headers.vcl.erb'),
            notify  => Class['varnish::reload'];
        [
            '/etc/varnish/conf.d/acl.vcl',
            '/etc/varnish/conf.d/deliver.vcl',
            '/etc/varnish/conf.d/hit.vcl',
            '/etc/varnish/conf.d/miss.vcl',
            '/etc/varnish/conf.d/pass.vcl',
            '/etc/varnish/conf.d/pipe.vcl',
        ]:
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/empty',
            notify  => Class['varnish::reload'];
    }
    common::concat { [
        '/etc/varnish/conf.d/backend.vcl',
        '/etc/varnish/conf.d/recv.vcl',
        '/etc/varnish/conf.d/fetch.vcl'
        ]:
            notify  => Class['varnish::reload'],
    }
    common::concat::fragment {
        '/etc/varnish/conf.d/recv.vcl-header':
            target  => '/etc/varnish/conf.d/recv.vcl',
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/recv.vcl-header',
            order   => 01;
        '/etc/varnish/conf.d/recv.vcl-footer':
            target  => '/etc/varnish/conf.d/recv.vcl',
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/recv.vcl-footer',
            order   => 99;
        '/etc/varnish/conf.d/fetch.vcl-header':
            target  => '/etc/varnish/conf.d/fetch.vcl',
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/fetch.vcl-header',
            order   => 01;
        '/etc/varnish/conf.d/fetch.vcl-footer':
            target  => '/etc/varnish/conf.d/fetch.vcl',
            source  => 'puppet:///modules/varnish/etc/varnish/conf.d/fetch.vcl-footer',
            order   => 99;
    }
}
