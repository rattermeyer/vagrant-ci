#::/bin/sh
#!/bin/bash
url=http://updates.jenkins-ci.org/download/plugins
for x in async-http-client/1.7.4/async-http-client.hpi \
    build-pipeline-plugin/1.4.3/build-pipeline-plugin.hpi \
    build-timeout/1.14/build-timeout.hpi \
    chucknorris/0.5/chucknorris.hpi \
    chosen-views-tabbar/1.2/chosen-views-tabbar.hpi \
    conditional-buildstep/1.3.3/conditional-buildstep.hpi \
    config-file-provider/2.7.5/config-file-provider.hpi \
    credentials/1.16.1/credentials.hpi \
    delivery-pipeline-plugin/0.8.6/delivery-pipeline-plugin.hpi \
    docker-plugin/0.7/docker-plugin.hpi \
    join/1.15/join.hpi \
    git/2.2.5/git.hpi \
    git-client/1.10.1/git-client.hpi \
    gitlab-hook/1.1.0/gitlab-hook.hpi \
    greenballs/1.14/greenballs.hpi \
    jobConfigHistory/2.9/jobConfigHistory.hpi \
    jquery/1.7.2-1/jquery.hpi \
    jquery-ui/1.0.2/jquery-ui.hpi \
    nodejs/0.2.1/nodejs.hpi \
    maven-deployment-linker/1.5.1/maven-deployment-linker.hpi \
    parameterized-trigger/2.25/parameterized-trigger.hpi \
    rebuild/1.22/rebuild.hpi \
    repository-connector/1.0.1/repository-connector.hpi \
    ruby-runtime/0.12/ruby-runtime.hpi \
    run-condition/1.0/run-condition.hpi \
    scm-api/0.2/scm-api.hpi \
    shelve-projects-plugin/1.9/shelve-projects-plugin.hpi \
    sonar/2.1/sonar.hpi \
    ssh-credentials/1.9/ssh-credentials.hpi \
    ssh-slaves/1.8/ssh-slaves.hpi \
    swarm/1.20/swarm.hpi \
    thinBackup/1.7.4/thinBackup.hpi \
    token-macro/1.10/token-macro.hpi \
    view-job-filters/1.26/view-job-filters.hpi \
    xvfb/1.0.12/xvfb.hpi \
    ; do
    wget "$url/$x" -P $1
done
