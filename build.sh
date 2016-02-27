#!/usr/bin/env bash

docker build -t tutum/lamp ./lamp
docker push tutum/lamp
docker build -t kevs/app ./app
docker push kevs/app

docker run -d -p 80:80 -p 3306:3306 kevs/app
