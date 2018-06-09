#!/bin/bash
SERVICE=bravia-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    --restart always \
    --name $SERVICE \
    -e BRAVIA_HOSTS="sony-810c,sony-850c" \
    -e MQTT_HOST=mqtt://ha \
    robodomo/$SERVICE

