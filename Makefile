CORE_TAGS := 8u322-b06-jdk-2cce095 11.0.14.1_1-jdk-2cce095
JOBS := $(addprefix core-,${CORE_TAGS})
CHECK_JOBS := $(addprefix check-,${CORE_TAGS})
CLEAN_JOBS := $(addprefix clean-,${CORE_TAGS})

all: ${CHECK_JOBS} ${JOBS}
check: ${CHECK_JOBS}
clean: ${CLEAN_JOBS}
.PHONY: all check clean ${JOBS} ${CHECK_JOBS} ${CLEAN_JOBS}

${JOBS}: core-%: Dockerfile
	docker build \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-sbt:$*-SNAPSHOT \
	  .

${CHECK_JOBS}: check-%:
	grep --silent "^          - $*$$" .github/workflows/ci.yml

${CLEAN_JOBS}: clean-%:
	docker image rm --force dwolla/jenkins-agent-sbt:$*-SNAPSHOT