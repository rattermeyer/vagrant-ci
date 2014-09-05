repos:
-----

base: java-dev-box
prepare-vagrant-user
prepare-ci-user with insecure key pair
install: nexus, sonar, bare git repo
link: cimaster, db
data-volume für nexus

db:
-----
mysql db
data-volume für mysql
reuse: prepared mysql docker image


cimaster
-------
base: java-dev-box
prepare-ci-user with insecure key pair
install: jenkins + plugins (via puppet)
link: repos
create: base jenkins jobs
cimaster users dynamic cislaves

cislave
--------
based on java-dev-box
volume for jenkins workspace
installed: swarm plugin
prepare-vagrant-user with insecure key pair



