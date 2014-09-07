#!/bin/sh
docker run -d --name "$1" --link "cimaster:cimaster" --link "repos:repos" -P slave-1 -master http://cimaster:8080/jenkins -executors 1 -name slave-1 -fsroot /var/lib/jenkins
