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

SERVICE=autelis-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing $SERVICE"
docker rm $SERVICE

echo "pulling RoboDomo/$SERVICE"
docker pull robodomo/$SERVICE

docker run \
    -d \
    --log-opt max-size=10m --log-opt max-file=5 \
    --restart always \
    --name $SERVICE \
    -e TITLE=$SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    robodomo/$SERVICE

