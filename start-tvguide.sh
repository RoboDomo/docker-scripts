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
    -e "TVGUIDE_USERNAME=$TVGUIDE_USERNAME" \
    -e "TVGUIDE_PASSWORD=$TVGUIDE_PASSWORD" \
    -e "TVGUIDE_IDS=$TVGUIDE_IDS" \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

