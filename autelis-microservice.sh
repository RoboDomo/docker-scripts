#!/bin/bash
SERVICE=autelis-microservice

echo "stopping $SERVICE"
docker stop $SERVICE
docker rm $SERVICE
docker run \
    -d \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

