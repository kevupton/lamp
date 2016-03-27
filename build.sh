#!/usr/bin/env bash

./stop.sh

docker rm $(docker ps -aq)

echo "Building..."

docker build -t tutum/lamp ./lamp
docker push tutum/lamp
docker build -t kevs/app ./app
docker push kevs/app

echo "Deleting nullafied images..."
docker rmi $(docker images -f "dangling=true" -q)

./start.sh
