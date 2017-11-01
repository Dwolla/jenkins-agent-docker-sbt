FROM dwolla/jenkins-agent-core
MAINTAINER Dwolla Dev <dev+jenkins-sbt@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

ENV SBT_VERSION=1.0.3 \
    SBT_HOME=/usr/local/sbt
ENV PATH=${SBT_HOME}/bin:${PATH}

USER root

COPY fake-project $JENKINS_HOME/fake-project

RUN apk add --no-cache git bc && \
    curl -sL /tmp/sbt-${SBT_VERSION}.tgz "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | \
    gunzip | tar -x -C /usr/local && \
    chown -R jenkins $JENKINS_HOME

USER jenkins
RUN cd $JENKINS_HOME/fake-project && \
    echo sbt.version=0.13.16 > project/build.properties && \
    sbt -Dsbt.log.noformat=true clean +compile && \
    echo sbt.version=${SBT_VERSION} > project/build.properties && \
    sbt -Dsbt.log.noformat=true clean +compile && \
    rm -rf $JENKINS_HOME/fake-project
