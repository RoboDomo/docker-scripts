#!/bin/bash
SERVICE=tvguide-microservice

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
    robodomo/$SERVICE

