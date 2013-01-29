class xvfb::user {

    group { 'xvfb':
        ensure  => present,
    }

    user { 'xvfb':
        ensure      => present,
        gid         => 'xvfb',
        shell       => '/bin/bash',
        managehome  => true,
        require     => Group['xvfb'],
    }

    file { '/home/xvfb':
        ensure      => directory,
        owner       => 'xvfb',
        group       => 'xvfb',
    }

}

