#!/usr/bin/env bash

./stop.sh
echo "Starting..."
docker run -d -p 80:80 -p 3306:3306 kevs/app