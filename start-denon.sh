#!/bin/bash
SERVICE=denon-microservice

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
    -e DENON_HOSTS="denon-s910w,denon-x2100w" \
    -e MQTT_HOST=http://ha \
    robodomo/$SERVICE

