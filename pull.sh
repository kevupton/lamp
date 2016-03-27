#!/usr/bin/env bash

DOCKER_ID=$(docker ps -q -f "image-name=kevs/app" -n=1)

if [ ! -z "$DOCKER_ID" ] ; then
    echo "Pulling Repo: $DOCKER_ID"
    docker exec ${DOCKER_ID} /pull
fi