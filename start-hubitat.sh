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

# HUBITAT_HUB is the hostname of your HUBITAT_HUB, typically "hubitat"
if [ "$HUBITAT_HUB" = "" ]; then
  echo "HUBITAT_HUB ENV variable is not set"
  exit 1
fi
 
# You must enable the MAKER API on your hubitat hub and enable the devices for control.  On the settings page,
# the access_token is displayed.  This is the value you need to set HUBITAT_TOKEN ENV variable.
if [ "$HUBITAT_TOKEN" = "" ]; then
  echo "HUBITAT_TOKEN ENV variable is not set"
  exit 1
fi
  
#### /ENV VARS

SERVICE=hubitat-microservice

DEBUG="hubitat"
#DEBUG="HostBase,hubitat" \


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
    --restart unless-stopped \
    --name $SERVICE \
    --expose 4000 \
    -e DEBUG="$DEBUG" \
    -e MQTT_HOST=$MQTT_HOST \
    -e HUBITAT_HUB=$HUBITAT_HUB \
    -e HUBITAT_TOKEN=$HUBITAT_TOKEN \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

