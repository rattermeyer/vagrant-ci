FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# Git
RUN apt-get install -y git dnsutils
# Vagrant
ADD ./prepare-vagrant-user.sh /tmp/
RUN /tmp/prepare-vagrant-user.sh 

# Disable (only for Demo!!!!) secure host checking
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN echo UserKnownHostsFile /dev/null >> /etc/ssh/ssh_config

# Jenkins user
RUN adduser --home /var/lib/jenkins jenkins
RUN echo 'jenkins:jenkins' | chpasswd
RUN sudo -u jenkins mkdir -p /var/lib/jenkins/.ssh 
RUN chown -R jenkins:jenkins /var/lib/jenkins/.ssh
ADD ci_insecure.pub /var/lib/jenkins/.ssh/authorized_keys
ADD ci_insecure.pub /var/lib/jenkins/.ssh/id_rsa.pub
ADD ci_insecure /var/lib/jenkins/.ssh/id_rsa
RUN chown jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa 
RUN chmod 0700 /var/lib/jenkins/.ssh && chmod 0600 /var/lib/jenkins/.ssh/*
VOLUME ["/var/lib/jenkins/jobs"]

# Swarm Client
RUN sudo -u jenkins curl -o /var/lib/jenkins/swarm-client-1.15-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.15/swarm-client-1.15-jar-with-dependencies.jar
#ENTRYPOINT ["sudo", "-u", "jenkins", "java", "-jar", "/var/lib/jenkins/swarm-client-1.15-jar-with-dependencies.jar"]

# expose ssh 
# EXPOSE 22 
#CMD ["/sbin/my_init"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD sudo -u jenkins java -jar /var/lib/jenkins/swarm-client-1.15-jar-with-dependencies.jar -master http://`dig +short jenkinsci_jenkinsmaster.dev.docker`:8080/jenkins/ -executors 1 -fsroot /var/lib/jenkins
