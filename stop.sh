#!/usr/bin/env bash

DOCKER_ID=$(docker ps -q -f "image-name=kevs/app" -n=1)

if [ ! -z "$DOCKER_ID" ] ; then
    echo "Stopping docker container $DOCKER_ID"
    docker stop ${DOCKER_ID}
fi