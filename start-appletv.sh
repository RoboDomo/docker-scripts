#!/bin/bash
SERVICE=appletv-microservice

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
    --name $SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    robodomo/$SERVICE

