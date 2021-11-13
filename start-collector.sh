#!/bin/bash

#### ENV VARS

SERVICE=collector-microservice
. ./lib/common.sh

stop
pull
start -v $PWD/config:/home/app/config -v /home/app/node_modules

#docker run \
#    -d \
#    --log-opt max-size=10m --log-opt max-file=5 \
#    -v $PWD/config:/home/app/config \
#    -v /home/app/node_modules \
#    --restart unless-stopped \
#    --name $SERVICE \
#    -e TITLE=$SERVICE \
#    -e MQTT_HOST=$MQTT_HOST \
#    -e MONGO_URL=$MONGO_URL \
#    -e ROBODOMO_MONGODB=$MONGO_URL \
#    robodomo/$SERVICE

