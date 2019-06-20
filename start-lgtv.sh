#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of Sony/Bravia TV hostnames/IP addresses that are to be controlled by
# this microservice
# LGTV_HOSTS=tv1,tv2,...

# Change this to match your MQTT broker hostname:
MQTT_HOST="mqtt://robodomo"

#### /ENV VARS

if [[ "$LGTV_HOSTS" == "" ]]; then
  echo "ENV variable LGTV_HOSTS is required but is not set.  See start-lgtv.sh for more details"
  exit 1
fi

SERVICE=lgtv-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    --net=host \
    --restart always \
    -v /home/app/.local/robodomo \
    --name $SERVICE \
    -e LGTV_HOSTS=$LGTV_HOSTS \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

