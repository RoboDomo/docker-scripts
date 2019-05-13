#!/bin/bash
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
    --name $SERVICE \
    -e LGTV_HOSTS="olede6p;78:5d:c8:e6:3f:ef" \
    -e MQTT_HOST=mqtt://ha \
    robodomo/$SERVICE

