#!/usr/bin/env bash

./stop.sh

docker rm $(docker ps -aq)

docker build -t tutum/lamp ./lamp
docker push tutum/lamp
docker build -t kevs/app ./app
docker push kevs/app

docker rmi $(docker images -f "dangling=true" -q)

./start.sh
