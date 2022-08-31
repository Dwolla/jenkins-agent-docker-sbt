# Jenkins Agent with sbt

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-sbt.svg)](https://microbadger.com/images/dwolla/jenkins-agent-sbt)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-sbt.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-sbt/blob/master/LICENSE)

Docker image based on Dwolla’s [sbt-version-cache](https://github.com/Dwolla/docker-sbt-version-cache) and [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [sbt](http://scala-sbt.org) available to Jenkins jobs.

GitHub Actions will build the Docker images for multiple supported architectures.

## Local Development
See [utilizing YQ to build caller workflows locally](https://github.com/Dwolla/jenkins-agents-workflow#utilizing-yq-to-build-caller-workflow-images-locally).