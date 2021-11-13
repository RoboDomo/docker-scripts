#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of AVR hostnames/IP addresses that are to be controlled by
# this microservice
# RING_TOKEN=token

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

#### /ENV VARS

if [[ "$RING_TOKEN" == "" ]]; then
  echo "ENV variable RING_TOKEN is required but is not set.  See start-ring.sh for more details"
  exit 1
fi

SERVICE=ring-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    --log-opt max-size=10m --log-opt max-file=5 \
    --restart unless-stopped \
    --name $SERVICE \
    -e RING_TOKEN=$RING_TOKEN \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

