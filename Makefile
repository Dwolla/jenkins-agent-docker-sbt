CORE_TAG := $(CORE_JDK11_TAG)
JOB := core-${CORE_TAG}
CLEAN_JOB := clean-${CORE_TAG}

# Default target builds Java 11, 17, and 21 variants
# Note: Uses full core image tags with git hashes
all: core-4.13.2-1-jdk11-a73d9b7 core-4.13.3-1-jdk17-be1c890 core-3355.v388858a_47b_33-5-jdk21-be1c890
clean: ${CLEAN_JOB}
.PHONY: all clean ${JOB} ${CLEAN_JOB} core-4.13.2-1-jdk11-a73d9b7 core-4.13.3-1-jdk17-be1c890 core-3355.v388858a_47b_33-5-jdk21-be1c890

${JOB}: core-%: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-sbt:$*-SNAPSHOT \
	  .

core-4.13.2-1-jdk11-a73d9b7: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=4.13.2-1-jdk11-a73d9b7 \
	  --tag dwolla/jenkins-agent-sbt:4.13.2-1-jdk11-a73d9b7-SNAPSHOT \
	  .

core-4.13.3-1-jdk17-be1c890: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=4.13.3-1-jdk17-be1c890 \
	  --tag dwolla/jenkins-agent-sbt:4.13.3-1-jdk17-be1c890-SNAPSHOT \
	  .

core-3355.v388858a_47b_33-5-jdk21-be1c890: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=3355.v388858a_47b_33-5-jdk21-be1c890 \
	  --tag dwolla/jenkins-agent-sbt:3355.v388858a_47b_33-5-jdk21-be1c890-SNAPSHOT \
	  .

${CLEAN_JOB}: clean-%:
	docker image rm --force dwolla/jenkins-agent-sbt:$*-SNAPSHOT
