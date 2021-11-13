#!/bin/bash

echo "This service (weather-microservice) is deprecated since Google is ending its works with nest API."j
echo "Use here.com-miroservice instead!"
exit 1

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
    --log-opt max-size=10m --log-opt max-file=5 \
    -e WEATHER_LOCATIONS="92211,92109,92203" \
    --restart unless-stopped \
    --name $SERVICE \
    robodomo/$SERVICE

