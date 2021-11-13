#!/bin/bash

SERVICE=mqtt-bridge
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# The SmartThings-MQTT-Bridge reads its configuration from a yaml (.yml) file and creates log files and other state
# files.  A good default location is /opt/mqtt-bridge, but you can use any directory you choose.  You should copy the
# mqtt-bridge-config.yml to /opt/mqtt-bridge/config.yml (or whatever other directry you choose) and edit it.  The
# values are reasonable choices - perhaps you need to just change the mqtt host name.
BRIDGE_CONFIG_LOCATION=/opt/mqtt-bridge

#### /ENV VARS

if [[ "$BRIDGE_CONFIG_LOCATION" == "" ]]; then
  echo "The BRIDGE_CONFIG_LOCATION environment variable is required but not set.  See start-smartthings.sh for details."
  exit 1
fi

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull stjohnjohnson/smartthings-mqtt-bridge

echo "starting new $SERVICE"
docker run \
    -d \
    --log-opt max-size=10m --log-opt max-file=5 \
    --restart unless-stopped \
    -v $BRIDGE_CONFIG_LOCATION:/config \
    -p 8080:8080 \
    --name $SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e TITLE=$SERVICE \
    stjohnjohnson/smartthings-mqtt-bridge

