FROM dwolla/jenkins-agent-core
MAINTAINER Dwolla Dev <dev+jenkins-sbt@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

ENV SBT_VERSION=0.13.12 \
    SBT_HOME=/usr/local/sbt \
    SCALA_VERSION=2.11.8
ENV PATH=${SBT_HOME}/bin:${PATH}

USER root

RUN apk add --update git && \
    curl -sL /tmp/sbt-${SBT_VERSION}.tgz "https://dl.bintray.com/sbt/native-packages/sbt/${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | \
    gunzip | tar -x -C /usr/local && \
    rm -rf /var/cache/apk/*

USER jenkins
RUN printf "set scalaVersion := \"${SCALA_VERSION}\"\nupdate-sbt-classifiers\nsbtVersion\n" | sbt && \
    rm -rf $JENKINS_HOME/project/ $JENKINS_HOME/target/
