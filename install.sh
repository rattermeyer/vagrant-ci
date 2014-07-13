#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get install -y git ruby-all-dev vim vim-puppet puppet-lint 
curl -s https://get.docker.io/ubuntu/ | sudo sh
gem install bundler
gem install hiera
gem install librarian-puppet
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
puppet apply --modulepath=/opt/puppet/modules/ --hiera_config=/opt/puppet/hiera.yaml /opt/puppet/manifests/nodes.pp
