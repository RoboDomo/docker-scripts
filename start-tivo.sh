#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of TiVo hostnames/IP addresses that are to be controlled by
# this microservice
# TIVO_HOSTS=bolt1,mini1,mini2,...

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

#### /ENV VARS

if [[ "$TIVO_HOSTS" == "" ]]; then
  echo "ENV variable TIVO_HOSTS is required but is not set.  See start-tivo.sh for more details"
  exit 1
fi

SERVICE=tivo-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    -e TIVO_HOSTS="$TIVO_HOSTS" \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

