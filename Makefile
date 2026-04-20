CORE_TAG := $(CORE_JDK11_TAG)
JOB := core-${CORE_TAG}
CLEAN_JOB := clean-${CORE_TAG}

# Default target builds Java 11, 17, and 21 variants
# Note: Uses full core image tags with git hashes
all: core-3261.v9c670a_4748a_9-8-jdk11-2bbea7f core-3261.v9c670a_4748a_9-8-jdk17-2bbea7f core-3261.v9c670a_4748a_9-8-jdk21-2bbea7f
clean: ${CLEAN_JOB}
.PHONY: all clean ${JOB} ${CLEAN_JOB} core-3261.v9c670a_4748a_9-8-jdk11-2bbea7f core-3261.v9c670a_4748a_9-8-jdk17-2bbea7f core-3261.v9c670a_4748a_9-8-jdk21-2bbea7f

${JOB}: core-%: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-sbt:$*-SNAPSHOT \
	  .

core-3261.v9c670a_4748a_9-8-jdk11-2bbea7f: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=3261.v9c670a_4748a_9-8-jdk11-2bbea7f \
	  --tag dwolla/jenkins-agent-sbt:3261.v9c670a_4748a_9-8-jdk11-2bbea7f-SNAPSHOT \
	  .

core-3261.v9c670a_4748a_9-8-jdk17-2bbea7f: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=3261.v9c670a_4748a_9-8-jdk17-2bbea7f \
	  --tag dwolla/jenkins-agent-sbt:3261.v9c670a_4748a_9-8-jdk17-2bbea7f-SNAPSHOT \
	  .

core-3261.v9c670a_4748a_9-8-jdk21-2bbea7f: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=3261.v9c670a_4748a_9-8-jdk21-2bbea7f \
	  --tag dwolla/jenkins-agent-sbt:3261.v9c670a_4748a_9-8-jdk21-2bbea7f-SNAPSHOT \
	  .

${CLEAN_JOB}: clean-%:
	docker image rm --force dwolla/jenkins-agent-sbt:$*-SNAPSHOT
