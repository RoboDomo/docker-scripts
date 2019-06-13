#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
MQTT_HOST="mqtt://robodomo"

#### /ENV VARS

SERVICE=react-client

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing $SERVICE"
docker rm $SERVICE

echo "pulling RoboDomo/$SERVICE"
docker pull robodomo/$SERVICE

docker run \
    -d \
    --net=host \
    --restart always \
    --name $SERVICE \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

hn=`hostname`
echo ""
echo ""
echo "Point your browser at:"
echo "http://$hn:8000"
echo ""
echo ""

