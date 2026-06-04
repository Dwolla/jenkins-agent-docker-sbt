# Jenkins Agent with sbt

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-sbt.svg)](https://microbadger.com/images/dwolla/jenkins-agent-sbt)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-sbt.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-sbt/blob/master/LICENSE)

Docker image based on Dwolla’s [sbt-version-cache](https://github.com/Dwolla/docker-sbt-version-cache) and [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [sbt](http://scala-sbt.org) available to Jenkins jobs.

GitHub Actions will build the Docker images for multiple supported architectures.

## Local Development

To build this image locally, run:

```bash
make all
```

By default, `CORE_TAG` is resolved with [yq](https://github.com/mikefarah/yq) from the `CORE_TAG` default defined in [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml), so [yq](https://github.com/mikefarah/yq) must be installed for the default to work:

```bash
brew install yq
```

To build against a specific core image instead, pass `CORE_TAG` explicitly (this does not require [yq](https://github.com/mikefarah/yq)):

```bash
make CORE_TAG=<core-tag> all
```