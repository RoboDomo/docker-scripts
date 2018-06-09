#!/bin/bash

SERVICE=mosca

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

docker run \
  --name $SERVICE \
  -d \
  --restart always \
  -p 1883:1883 \
  -p 80:80 \
  -v /var/db/mosca:/db \
  matteocollina/mosca
