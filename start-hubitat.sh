#!/bin/bash

SERVICE=hubitat-microservice
. ./lib/common.sh

#### ENV VARS

# HUBITAT_HUB is the hostname of your HUBITAT_HUB, typically "hubitat"
if [ "$HUBITAT_HUB" = "" ]; then
  echo "HUBITAT_HUB ENV variable is not set"
  exit 1
fi
 
# You must enable the MAKER API on your hubitat hub and enable the devices for control.  On the settings page,
# the access_token is displayed.  This is the value you need to set HUBITAT_TOKEN ENV variable.
if [ "$HUBITAT_TOKEN" = "" ]; then
  echo "HUBITAT_TOKEN ENV variable is not set"
  exit 1
fi

if [[ -z "$DEBUG" ]]; then
  DEBUG="hubitat"
fi

#### /ENV VARS

stop
pull
start --net=host --expose 4000 -e DEBUG="$DEBUG" -e MQTT_HOST=$MQTT_HOST -e HUBITAT_HUB=$HUBITAT_HUB -e HUBITAT_TOKEN=$HUBITAT_TOKEN 
echo "DONE"

