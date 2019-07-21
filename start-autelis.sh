#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi


#### /ENV VARS

SERVICE=autelis-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing $SERVICE"
docker rm $SERVICE

echo "pulling RoboDomo/$SERVICE"
docker pull robodomo/$SERVICE

docker run \
    -d \
    --restart always \
    --name $SERVICE \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

