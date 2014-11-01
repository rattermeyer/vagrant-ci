FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

RUN rm -fR /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get upgrade -y --force-yes
RUN apt-get install -y --force-yes build-essential ruby-all-dev git vim 
RUN apt-get install -y --force-yes puppet vim-puppet puppet-lint libtinfo5
RUN gem install bundler
RUN gem install hiera
RUN gem install librarian-puppet
ADD ./prepare-vagrant-user.sh /tmp/
ADD ./install.sh /tmp/
RUN chmod u+x /tmp/*.sh
RUN /tmp/prepare-vagrant-user.sh 
RUN /tmp/install.sh
## Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
VOLUME ["/var/lib/jenkins/jobs"]
RUN mkdir -p /etc/service/jenkins
#ADD ./jenkins.sh /etc/service/jenkins/run
ADD ./jenkins.sh /usr/local/bin/jenkins
# RUN chmod u+x /usr/local/bin/jenkins
RUN mkdir -p /var/lib/jenkins/.ssh && chown -R jenkins:jenkins /var/lib/jenkins/.ssh
ADD ci_insecure /var/lib/jenkins/.ssh/id_rsa 
RUN chown jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa && chmod 600 /var/lib/jenkins/.ssh/id_rsa
ADD ci_insecure.pub /var/lib/jenkins/.ssh/id_rsa.pub 
ADD ssh_config /var/lib/jenkins/.ssh/config
# Create initial jenkins home with sample jobs
ADD jenkins_home.tar.gz /var/lib/jenkins
# Make sure jenkins home tree is owned by jenkins
RUN chown -R jenkins:jenkins /var/lib/jenkins/
# jenkins port
EXPOSE 22 8080
# Use baseimage-docker's init system.
# CMD ["/usr/local/bin/jenkins"]
