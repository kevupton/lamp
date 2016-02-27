#!/usr/bin/env bash

DOCKER_ID=$(docker ps -q -f "image-name=kevs/app" -n=1)

if [ ! -z "$DOCKER_ID" ] ; then
    sudo docker exec -i -t ${DOCKER_ID} bash
fi