#!/bin/sh
#apt-get update
#apt-get upgrade -y
apt-get install -y git ruby1.9.1-dev
gem install hiera
gem install librarian-puppet
apt-get install puppet
echo "Updating / Cloning /opt/puppet"
if [ -d /opt/puppet ] ; then
	cd /opt/puppet
	#rm Puppetfile.lock
	git pull
	librarian-puppet update
else
	git clone https://github.com/rattermeyer/puppet-main.git /opt/puppet
	cd /opt/puppet
	librarian-puppet install --verbose --clean
fi
echo "applying puppet"
puppet apply --modulepath=/opt/puppet/modules/ /opt/puppet/manifests/nodes.pp
