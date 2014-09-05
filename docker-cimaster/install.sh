#!/bin/sh
echo "Updating / Cloning /opt/puppet"
if [ -d /opt/puppet ] ; then
	cd /opt/puppet
	#rm Puppetfile.lock
	git pull
	librarian-puppet update
else
	git clone https://github.com/rattermeyer/puppet-main.git /opt/puppet
	cd /opt/puppet
        git checkout cimaster-docker
	librarian-puppet install --verbose --clean
fi
echo "applying puppet"
puppet apply --modulepath=/opt/puppet/modules/ --hiera_config=/opt/puppet/hiera.yaml /opt/puppet/manifests/nodes.pp
