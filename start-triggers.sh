#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
MQTT_HOST="mqtt://robodomo"

# Set this to the number of milliseconds that the bathroom fans should remain on
TIMEOUT=600000

#### /ENV VARS

SERVICE=triggers-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    --restart always \
    --name $SERVICE \
    -e TIMEOUT=$TIMEOUT \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

