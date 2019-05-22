#!/bin/bash
SERVICE=bravia-microservice

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
    -e BRAVIA_HOSTS="$BRAVIA_HOSTS" \
    -e MQTT_HOST=mqtt://ha \
    robodomo/$SERVICE

