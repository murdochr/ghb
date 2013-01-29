class xvfb::package {
    package {
                'xorg-x11-server-Xvfb': ensure  => 'installed';
                'dbus-x11':             ensure  => 'installed';
    }

    exec { 'dbus-uuidgen --ensure':
        path         => '/bin',

        subscribe    => Package['xorg-x11-server-Xvfb'],
        require      => Package['xorg-x11-server-Xvfb'],
        refreshonly  => true

    }
}

