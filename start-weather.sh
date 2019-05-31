#!/bin/bash
SERVICE=weather-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker run \
    -d \
    -e WEATHER_LOCATIONS="92211,92109,92203" \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

