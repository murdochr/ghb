USER=`whoami`

if [ $USER != 'root' ] 
	then echo 'Run as root user.'
	exit 1
fi

which dpkg
if [ $? == 0 ] ; 
then apt-get install puppet
fi

which yum
if [ $? == 0 ] ;
then yum install puppet
fi
