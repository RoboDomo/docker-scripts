#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of presence hostnames/IP addresses that are to be controlled by
# this microservice
# presence_HOSTS=bolt1,mini1,mini2,...

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://nuc1"
fi

#### /ENV VARS

SERVICE=presence-microservice

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
    --restart always \
    -e MQTT_HOST=$MQTT_HOST \
    -e MONGO_URL="mongodb://nuc1" \
    -e TITLE=$SERVICE \
    --name $SERVICE \
    robodomo/$SERVICE

