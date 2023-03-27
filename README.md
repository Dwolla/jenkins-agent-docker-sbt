# Jenkins Agent with sbt

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-sbt.svg)](https://microbadger.com/images/dwolla/jenkins-agent-sbt)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-sbt.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-sbt/blob/master/LICENSE)

Docker image based on Dwolla’s [sbt-version-cache](https://github.com/Dwolla/docker-sbt-version-cache) and [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [sbt](http://scala-sbt.org) available to Jenkins jobs.

GitHub Actions will build the Docker images for multiple supported architectures.

## Local Development

With [yq](https://kislyuk.github.io/yq/) installed, to build this image locally run the following command:

```bash
make \
    CORE_JDK11_TAG=$( curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | \
        yq .jobs.\"build-core-matrix\".strategy.matrix.TAG | yq '.[] | select (test(".*?jdk11.*?"))') \
    all
```

Alternatively, without [yq](https://kislyuk.github.io/yq/) installed, refer to the CORE_TAG default values defined in [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml) and run the following command:

`make CORE_JDK11_TAG=<default-core-jdk11-tag-from-jenkins-agents-workflow> CORE_JDK8_TAG=<default-core-jdk8-tag-from-jenkins-agents-workflow> all`