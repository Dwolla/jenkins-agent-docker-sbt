FROM dwolla/jenkins-agent-core
MAINTAINER Dwolla Dev <dev+jenkins-sbt@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

ENV SBT_VERSION=0.13.15 \
    SBT_HOME=/usr/local/sbt
ENV PATH=${SBT_HOME}/bin:${PATH}

USER root

COPY fake-project $JENKINS_HOME/fake-project

# (There is a bug in the sbt 0.13.13 packaging, so add a symlink in that specific case.)
RUN apk add --no-cache git && \
    curl -sL /tmp/sbt-${SBT_VERSION}.tgz "https://dl.bintray.com/sbt/native-packages/sbt/${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | \
    gunzip | tar -x -C /usr/local && \
    [ "0.13.13" = "${SBT_VERSION}" ] && ln -s /usr/local/sbt-launcher-packaging-0.13.13 /usr/local/sbt; \
    chown -R jenkins $JENKINS_HOME

USER jenkins
RUN cd $JENKINS_HOME/fake-project && \
    echo sbt.version=0.13.16 > project/build.properties && \
    sbt -Dsbt.log.noformat=true clean +compile && \
    echo sbt.version=1.0.1 > project/build.properties && \
    sbt -Dsbt.log.noformat=true clean +compile && \
    rm -rf $JENKINS_HOME/fake-project
