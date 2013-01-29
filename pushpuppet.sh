#!/bin/bash
#cd /tmp/vagrant-puppet/manifests && puppet apply --modulepath '/tmp/vagrant-puppet/modules-0' /tmp/vagrant-puppet/manifests/site.pp
#puppet apply puppet/site.pp
puppet apply --modulepath puppet/modules puppet/site.pp


