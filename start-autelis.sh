#!/bin/bash
SERVICE=autelis-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing $SERVICE"
docker rm $SERVICE

echo "pulling RoboDomo/$SERVICE"
docker pull Robodomo/$SERVICE

docker run \
    -d \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

