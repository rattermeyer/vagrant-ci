#!/bin/sh
IP_ADDRESS=`docker inspect $1 | grep "IPAddress"  | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo -u jenkins tar -C /var/lib/jenkins --exclude='.ssh' --exclude='workspace' --exclude='builds' --exclude='./plugins' --exclude='./.m2' --exclude='./.jenkins' --exclude='./tools' --exclude='cache' --exclude='secrets' --exclude='fingerprints' -czvf /tmp/jenkins_home.tar.gz .
scp -i vagrant_key vagrant@${IP_ADDRESS}:/tmp/jenkins_home.tar.gz .

