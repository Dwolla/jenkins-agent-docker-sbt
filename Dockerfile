# check=skip=InvalidDefaultArgInFrom
# The base image ARGs have no defaults on purpose: CI and the Makefile always pass them, from ci.yml.
ARG CORE_TAG
# The build JDK this image's label promises (java11-sbt, java17-sbt, java21-sbt, java25-sbt). The agent itself
# runs on the core image's Java 21 through JENKINS_JAVA_BIN; builds use this JDK as JAVA_HOME.
ARG BUILD_JDK_IMAGE

FROM ${BUILD_JDK_IMAGE} AS build-jdk
FROM dwolla/sbt-version-cache AS sbt-cache
FROM dwolla/sbt-plugins-cache AS sbt-plugins-cache
FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-sbt@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

COPY --from=build-jdk /opt/java/openjdk /opt/java/build-jdk

ENV SBT_VERSION=1.5.5 \
    SBT_HOME=/usr/local/sbt \
    JAVA_HOME=/opt/java/build-jdk
ENV PATH=${SBT_HOME}/bin:${JAVA_HOME}/bin:${PATH}

COPY --from=sbt-cache /usr/local/sbt /usr/local/sbt
COPY --from=sbt-cache /root/.cache/coursier ${JENKINS_HOME}/.cache/coursier
COPY --from=sbt-cache /root/.ivy2 ${JENKINS_HOME}/.ivy2
COPY --from=sbt-cache /root/.sbt ${JENKINS_HOME}/.sbt
COPY --from=sbt-plugins-cache /root/.ivy2 ${JENKINS_HOME}/.ivy2
COPY --from=sbt-plugins-cache /root/.sbt ${JENKINS_HOME}/.sbt

USER root
RUN chown -R jenkins ${JENKINS_HOME}

USER jenkins
