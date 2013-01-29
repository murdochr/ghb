class xvfb::config {
    file {
        '/etc/init.d/xvfb':
            source  => 'puppet:///modules/xvfb/etc/init.d/xvfb',
            mode    => '0755';

    '/var/log/xvfb':
            ensure  => 'directory',
            owner   => 'xvfb',
            group   => 'xvfb';
    }
}
