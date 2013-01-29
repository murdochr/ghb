node rm-ubuntu {
	notify{'blah':}
    #class{'pidgin':}
    package {'vim': ensure  =>  installed}
    class{'vimsofttab':}
}

