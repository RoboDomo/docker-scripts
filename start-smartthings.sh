#!/bin/bash
SERVICE=mqtt-bridge

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull stjohnjohnson/smartthings-mqtt-bridge

echo "starting new $SERVICE"
docker run \
    -d \
    --restart always \
    -v /opt/mqtt-bridge:/config \
    -p 8080:8080 \
    --name $SERVICE \
    stjohnjohnson/smartthings-mqtt-bridge

