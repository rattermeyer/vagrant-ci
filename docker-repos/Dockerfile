FROM devopsarchitect/devbase
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# Install Puppet 
RUN apt-get install -y puppet
# Prepare for Vagrant
ADD ./prepare-vagrant-user.sh /tmp/
RUN chmod u+x /tmp/prepare-vagrant-user.sh
RUN /tmp/prepare-vagrant-user.sh 
VOLUME ["/srv/sonatype-work"]
# Still needed? Is set on startup script
RUN touch /srv/sonatype-work/.to_keep_permissions
# Setup nexus using puppet
ADD puppet /opt/puppet
RUN puppet apply --modulepath /opt/puppet/modules /opt/puppet/manifests/site.pp
# Install startup script
RUN mkdir /etc/service/nexus
ADD nexus.sh /etc/service/nexus/run
# Clone Sample Project
RUN git clone --bare https://github.com/rattermeyer/todolist-demo.git /home/git/todolist-demo.git && chown -R git:git /home/git/todolist-demo.git
ADD ./prepare-git-user.sh /tmp/prepare-git-user.sh
RUN /tmp/prepare-git-user.sh
# Prepare Nexus (esp. add candidates repository)
ADD nexus-work.tar.gz /srv/sonatype-work/nexus/
# enable link access via ssh (git) and to Nexus
EXPOSE 22 8081
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

