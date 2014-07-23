#!/bin/sh
apt-get update
apt-get upgrade -y
apt-get install -y git curl openssh-server 
DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
curl -k -s https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.1.0-omnibus-1_amd64.deb > gitlab_7.0.0-omnibus-1_amd64.deb
dpkg -i gitlab_7.1.0-omnibus-1_amd64.deb
gitlabctl reconfigure
