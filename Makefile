CORE_TAG ?= $(shell curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | yq .on.workflow_call.inputs.CORE_TAG.default)
# The build JDK (11, 17 or 21); its pinned image is read from the CI matrix
BUILD_JDK ?= 11
BUILD_JDK_IMAGE ?= $(shell yq '.jobs.build.strategy.matrix.include[] | select(.build_jdk == $(BUILD_JDK)) | .build_jdk_image' .github/workflows/ci.yml)
TAG := ${CORE_TAG}-build-jdk${BUILD_JDK}-SNAPSHOT

all: build
.PHONY: all build clean

build: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=${CORE_TAG} \
	  --build-arg BUILD_JDK_IMAGE=${BUILD_JDK_IMAGE} \
	  --tag dwolla/jenkins-agent-sbt:${TAG} \
	  .

clean:
	docker image rm --force dwolla/jenkins-agent-sbt:${TAG}
