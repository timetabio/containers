#!/bin/bash

CONTAINERS=$(<containers.txt)

set -e

for CONTAINER in ${CONTAINERS[@]}; do
    TAG=docker.ttio.cloud:5000/${CONTAINER}:latest

    tput setaf 2
    echo "==> Pushing container '${TAG}'..."
    tput sgr0

    docker push ${TAG}
done