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
    -e DENON_HOSTS=$DENON_HOSTS \
    -e MQTT_HOST=$MQTT_HOST \
    robodomo/$SERVICE

