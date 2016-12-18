#!/bin/bash

CONTAINERS=$(<containers.txt)

set -e

for CONTAINER in ${CONTAINERS[@]}; do
    EXPLODED_NAME=(${CONTAINER/\// })
    SHORT_NAME=${EXPLODED_NAME[${#EXPLODED_NAME[@]}-1]}
    TAG=docker.ttio.cloud:5000/${CONTAINER}:latest

    tput setaf 2
    echo "==> Building container '${TAG}'..."
    tput sgr0

    docker build -t ${TAG} -f ${SHORT_NAME}/Dockerfile .
done