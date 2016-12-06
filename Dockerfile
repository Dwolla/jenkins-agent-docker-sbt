FROM dwolla/jenkins-agent-core
MAINTAINER Dwolla Dev <dev+jenkins-sbt@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

ENV SBT_VERSION=0.13.13 \
    SBT_HOME=/usr/local/sbt \
    SCALA_VERSION=2.11.8
ENV PATH=${SBT_HOME}/bin:${PATH}

USER root

# (There is a bug in the sbt 0.13.13 packaging, so add a symlink in that specific case.)
RUN apk add --update git && \
    curl -sL /tmp/sbt-${SBT_VERSION}.tgz "https://dl.bintray.com/sbt/native-packages/sbt/${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | \
    gunzip | tar -x -C /usr/local && \
    [ "0.13.13" = "${SBT_VERSION}" ] && ln -s /usr/local/sbt-launcher-packaging-0.13.13 /usr/local/sbt; \
    rm -rf /var/cache/apk/*

USER jenkins
RUN printf "set scalaVersion := \"${SCALA_VERSION}\"\nupdate-sbt-classifiers\nsbtVersion\n" | sbt && \
    rm -rf $JENKINS_HOME/project/ $JENKINS_HOME/target/
