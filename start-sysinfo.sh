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

SERVICE=sysinfo-microservice

DEBUG="sysinfo"
#DEBUG="HostBase,sysinfo" \


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
    --net=host \
    --restart always \
    --name $SERVICE \
    --expose 4000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e DEBUG="$DEBUG" \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

