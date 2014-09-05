FROM devopsarchitect/devbase
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

RUN apt-get install -y puppet
ADD ./prepare-vagrant-user.sh /tmp/
RUN chmod u+x /tmp/prepare-vagrant-user.sh
RUN /tmp/prepare-vagrant-user.sh 
VOLUME ["/srv/sonatype-work"]
RUN touch /srv/sonatype-work/.to_keep_permissions
ADD puppet /opt/puppet
RUN puppet apply --modulepath /opt/puppet/modules /opt/puppet/manifests/site.pp
RUN mkdir /etc/service/nexus
ADD nexus.sh /etc/service/nexus/run
RUN git clone --bare https://github.com/rattermeyer/todolist-demo.git /home/git/todolist-demo.git && chown -R git:git /home/git/todolist-demo.git
ADD ./prepare-git-user.sh /tmp/prepare-git-user.sh
RUN /tmp/prepare-git-user.sh
EXPOSE 22 8081
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

