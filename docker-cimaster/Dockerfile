FROM rattermeyer/devbase:2
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

RUN apt-get update
RUN apt-get install build-essential ruby-all-dev
ADD ./prepare-vagrant-user.sh /tmp/
ADD ./install.sh /tmp/
RUN chmod u+x /tmp/*.sh
RUN /tmp/prepare-vagrant-user.sh 
RUN /tmp/install.sh
