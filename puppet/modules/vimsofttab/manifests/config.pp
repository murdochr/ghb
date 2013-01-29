class vimsofttab::config {
    notify {'vimsofttab::config':}
    file {'/etc/vim/vimrc.local':
            ensure  => file,
            source  =>  'puppet:///modules/vimsofttab/etc/vim/vimrc.local',
            owner   =>  'root',
            group   =>  'root',
            mode    =>  '0644',
            force   =>  true,
    }
}
