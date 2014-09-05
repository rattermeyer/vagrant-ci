#!/bin/sh
IP_ADDRESS=`docker inspect $1 | grep "IPAddress"  | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}
scp -i vagrant_key jenkins_home.tar.gz vagrant@${IP_ADDRESS}:/tmp/jenkins_home.tar.gz 
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo -u jenkins tar -C /var/lib/jenkins --overwrite -xzvf /tmp/jenkins_home.tar.gz .

