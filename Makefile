CORE_TAG := $(CORE_JDK11_TAG)
JOB := core-${CORE_TAG}
CLEAN_JOB := clean-${CORE_TAG}

# Default target builds Java 11, 17, and 21 variants
# Note: For local builds, you'll need to provide CORE_JDK11_TAG and CORE_JDK17_TAG
# with the actual published core image tags (including git hashes)
all: core-4.13.2-1-jdk11 core-4.13.3-1-jdk17 core-3355.v388858a_47b_33-5-jdk21
clean: ${CLEAN_JOB}
.PHONY: all clean ${JOB} ${CLEAN_JOB} core-4.13.2-1-jdk11 core-4.13.3-1-jdk17 core-3355.v388858a_47b_33-5-jdk21

${JOB}: core-%: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-sbt:$*-SNAPSHOT \
	  .

core-4.13.2-1-jdk11: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=4.13.2-1-jdk11 \
	  --tag dwolla/jenkins-agent-sbt:4.13.2-1-jdk11-SNAPSHOT \
	  .

core-4.13.3-1-jdk17: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=4.13.3-1-jdk17 \
	  --tag dwolla/jenkins-agent-sbt:4.13.3-1-jdk17-SNAPSHOT \
	  .

core-3355.v388858a_47b_33-5-jdk21: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=3355.v388858a_47b_33-5-jdk21 \
	  --tag dwolla/jenkins-agent-sbt:3355.v388858a_47b_33-5-jdk21-SNAPSHOT \
	  .

${CLEAN_JOB}: clean-%:
	docker image rm --force dwolla/jenkins-agent-sbt:$*-SNAPSHOT
