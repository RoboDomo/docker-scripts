#!/bin/bash

SERVICE=pyatv-microservice
. ./lib/common.sh

stop
pull
start --net=host -e MQTT_HOSTNAME=$MQTT_HOSTNAME -e MONGO_HOST=$MONGO_HOST

