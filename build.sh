#!/usr/bin/env bash

./stop.sh

docker rm $(docker ps -aq)

docker build -t tutum/lamp ./lamp
docker push tutum/lamp
docker build -t kevs/app ./app
docker push kevs/app

docker rmi -f $(docker images -q -f "image-name=" )

./start.sh
