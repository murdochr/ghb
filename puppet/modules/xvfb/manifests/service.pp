class xvfb::service {
    service { 'xvfb':
        ensure      => running,
        enable      => true,
        subscribe   => Class[
                                'java::jdk',
                                'xvfb::config'
                            ],

        require     => Class[
                                'xvfb::package',
                                'xvfb::user'
                            ]
    }
}

