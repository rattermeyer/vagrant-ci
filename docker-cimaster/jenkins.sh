#!/bin/sh
exec /usr/sbin/sshd -D
chown -R jenkins:jenkins /var/lib/jenkins/jobs
exec sudo -u jenkins /usr/bin/java -Xmx1024m -Djava.awt.headless=true -DJENKINS_HOME=/var/lib/jenkins -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --ajp13Port=-1 --prefix=/jenkins
