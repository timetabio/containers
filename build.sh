#!/bin/bash

CONTAINERS=$(<containers.txt)

set -e

for CONTAINER in ${CONTAINERS[@]}; do
    EXPLODED_NAME=(${CONTAINER/\// })
    SHORT_NAME=${EXPLODED_NAME[${#EXPLODED_NAME[@]}-1]}
    TAG=docker.ttio.cloud:5000/${CONTAINER}:latest
    VERSION=${TRAVIS_TAG}

    if [ ! -z ${1} ]; then
        VERSION=${1}
    fi

    tput setaf 2
    if [ -z ${VERSION} ]; then
        echo "==> Building container '${TAG}' without version..."
    else
        echo "==> Building container '${TAG}' with version '${VERSION}'..."
    fi
    tput sgr0

    docker build -t ${TAG} -f ${SHORT_NAME}/Dockerfile .

    if [ ! -z ${VERSION} ]; then
        docker tag ${TAG} docker.ttio.cloud:5000/${CONTAINER}:${VERSION}
    fi
done