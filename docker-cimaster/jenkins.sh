#!/bin/sh
chown -R jenkins:jenkins /var/lib/jenkins/jobs
exec /sbin/setuser jenkins /usr/bin/java -Xmx1024m -Djava.awt.headless=true -DJENKINS_HOME=/var/lib/jenkins -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --ajp13Port=-1 --prefix=/jenkins
