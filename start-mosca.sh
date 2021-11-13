#!/bin/bash

SERVICE=mosca
. ./lib/common.sh

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull matteocollina/$SERVICE

# TODO figure out what ports 3000 and 9000 are open here for.
# 1883 is the standard MQTT port
# 80 is open for MQTT over websocket (for the websocket handshake, etc.)
docker run $docker_parmaeters \
  --net=host \
  -p 1883:1883 \
  -p 3000:3000 \
  -p 9000:9000 \
  -p 80:80 \
  -v /var/db/mosca:/db \
  matteocollina/mosca
