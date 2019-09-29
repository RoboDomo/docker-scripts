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

SERVICE=macro-microservice

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
    -e TITLE=$SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    robodomo/$SERVICE

echo ""
echo ""
echo ""
echo "You can edit config/Macros.js to add or change your macros."
echo "They will automatically be loaded/reloaded when the file is changed/saved."

