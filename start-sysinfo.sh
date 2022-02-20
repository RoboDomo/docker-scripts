#!/bin/bash

SERVICE=sysinfo-microservice
. ./lib/common.sh

#### ENV VARS

DEBUG="sysinfo"
#### /ENV VARS

stop
pull
start -e HOSTNAME=`hostname` -e DEBUG="$DEBUG" 

#docker run \
#    -d \
#    --log-opt max-size=10m --log-opt max-file=5 \
#    --net=host \
#    --restart unless-stopped \
#    --name $SERVICE \
#    --expose 4000 \
#    -v /var/run/docker.sock:/var/run/docker.sock \
#    -e DEBUG="$DEBUG" \
#    -e MQTT_HOST=$MQTT_HOST \
#    -e TITLE=$SERVICE \
#    robodomo/$SERVICE

