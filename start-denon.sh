#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of AVR hostnames/IP addresses that are to be controlled by
# this microservice
# DENON_HOSTS=denon1,denon2,...

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

if [[ "$DENON_HOSTS" == "" ]]; then
  echo "ENV variable DENON_HOSTS is required but is not set.  See start-denon.sh for more details"
  exit 1
fi

SERVICE=denon-microservice

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
    -e DENON_HOSTS=$DENON_HOSTS \
    -e MQTT_HOST=$MQTT_HOST \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

