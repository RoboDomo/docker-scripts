#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of AVR hostnames/IP addresses that are to be controlled by
# this microservice
# MYQ_HOSTS=myq1,myq2,...

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

SERVICE=myq-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    --restart unless-stopped \
    --name $SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e MYQ_EMAIL=$MYQ_EMAIL \
    -e MYQ_PASSWORD=$MYQ_PASSWORD \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

