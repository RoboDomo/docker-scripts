#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

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
    --log-opt max-size=10m --log-opt max-file=5 \
    --net=host \
    --restart unless-stopped \
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

