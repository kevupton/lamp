#!/usr/bin/env bash

docker build -t tutum/lamp ./lamp
docker push tutum/lamp
docker build -t kevs/app ./app

./start.sh
