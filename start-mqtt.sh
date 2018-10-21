#!/bin/bash

SERVICE=mosca

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull matteocollina/$SERVICE

docker run \
  --name $SERVICE \
  -d \
  --restart always \
  -p 1883:1883 \
  -p 3000:3000 \
  -p 9000:9000 \
  -p 80:80 \
  -v /var/db/mosca:/db \
  matteocollina/mosca
