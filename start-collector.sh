#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

SERVICE=collector-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    -v $PWD/config:/home/app/config \
    -v /home/app/node_modules \
    --restart always \
    --name $SERVICE \
    -e TITLE=$SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e MONGO_URL=$MONGO_URL \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    robodomo/$SERVICE

