ARG CORE_TAG

FROM dwolla/sbt-version-cache AS sbt-cache
FROM dwolla/sbt-plugins-cache AS sbt-plugins-cache
FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-sbt@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-sbt"

ENV SBT_VERSION=1.5.5 \
    SBT_HOME=/usr/local/sbt \
    JAVA_HOME=/opt/java/openjdk
ENV PATH=${SBT_HOME}/bin:${JAVA_HOME}/bin:${PATH}

COPY --from=sbt-cache /usr/local/sbt /usr/local/sbt
COPY --from=sbt-cache /root/.cache/coursier ${JENKINS_HOME}/.cache/coursier
COPY --from=sbt-cache /root/.ivy2 ${JENKINS_HOME}/.ivy2
COPY --from=sbt-cache /root/.sbt ${JENKINS_HOME}/.sbt
COPY --from=sbt-plugins-cache /root/.ivy2 ${JENKINS_HOME}/.ivy2
COPY --from=sbt-plugins-cache /root/.sbt ${JENKINS_HOME}/.sbt

USER root
RUN chown -R jenkins ${JENKINS_HOME}

RUN export SDKMAN_DIR="${JENKINS_HOME}/.sdkman" && curl -s "https://get.sdkman.io" | bash

RUN chown -R jenkins:jenkins "${JENKINS_HOME}/.sdkman"

USER jenkins
