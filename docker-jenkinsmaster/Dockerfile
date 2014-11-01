FROM java:openjdk-7u65-jdk

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV JENKINS_VERSION 1.580.1
RUN mkdir /usr/share/jenkins/
RUN useradd -d /home/jenkins -m -s /bin/bash jenkins

COPY init.groovy /tmp/WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy.d/tcp-slave-angent-port.groovy && rm -rf /tmp/WEB-INF

ENV JENKINS_HOME /var/jenkins_home
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

USER root

RUN apt-get install -y wget
ADD ./plugins.sh /tmp/plugins.sh
ADD patch-jenkins-war.sh /tmp/patch-jenkins-war.sh
RUN chmod u+x /tmp/*.sh && chown -R jenkins /tmp/plugins.sh 
ENV PLUGIN_DIR /tmp/plugins
RUN mkdir -p ${PLUGIN_DIR}
RUN /tmp/plugins.sh ${PLUGIN_DIR}
RUN /tmp/patch-jenkins-war.sh /usr/share/jenkins/jenkins.war ${PLUGIN_DIR} /tmp/jar
ADD jenkins_home.tar.gz ${JENKINS_HOME}

RUN mkdir -p ${JENKINS_HOME}/.ssh
ADD ci_insecure ${JENKINS_HOME}/.ssh/id_rsa && chmod 0600 ${JENKINS_HOME}/.ssh/id_rsa
ADD ci_insecure.pub ${JENKINS_HOME}/.ssh/id_rsa.pub
ADD ssh_config ${JENKINS_HOME}/.ssh/config

RUN chown -R jenkins:jenkins ${JENKINS_HOME}

VOLUME /var/jenkins_home
USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
