#!/bin/sh
IP_ADDRESS=`docker inspect $1 | grep "IPAddress"  | cut -d: -f2 | sed -e 's/"//g' -e 's/ //g' -e 's/,//g'`
echo ${IP_ADDRESS}
ssh -i vagrant_key vagrant@${IP_ADDRESS} sudo -u nexus tar -C /srv/sonatype-work/nexus --exclude=storage --exclude=indexer --exclude=felix-cache --exclude=timeline --exclude=nuget --exclude=*.lock --exclude=logs -czvf /tmp/nexus-work.tar.gz .
scp -i vagrant_key vagrant@${IP_ADDRESS}:/tmp/nexus-work.tar.gz .

