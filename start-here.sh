#!/bin/bash
SERVICE=here-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    -e WEATHER_LOCATIONS=$WEATHER_LOCATIONS \
    -e WEATHER_APP_ID=$WEATHER_APP_ID \
    -e WEATHER_APP_CODE=$WEATHER_APP_CODE \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

