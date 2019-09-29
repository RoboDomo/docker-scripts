#!/bin/bash

SERVICE=mongodb

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull mongo:3.4

docker run \
  --name $SERVICE \
  -d \
  --restart always \
  -p 27017:27017 \
  -v ~/data:/data/db \
  mongo:3.4

