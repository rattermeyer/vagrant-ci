#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get install -y git curl openssh-server
DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
curl -k -s https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_6.9.2-omnibus.1-1_amd64.deb > gitlab_6.9.2-omnibus.1-1_amd64.deb 
dpkg -i gitlab_6.9.2-omnibus.1-1_amd64.deb 
gitlabctl reconfigure
