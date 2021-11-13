#!/bin/sh

SERVICE=eclipse-mosquitto

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull $SERVICE

# TODO figure out what ports 3000 and 9000 are open here for.
# 1883 is the standard MQTT port
# 80 is open for MQTT over websocket (for the websocket handshake, etc.)
docker run \
  --name $SERVICE \
  -d \
  -p 1883:1883 \
  -p 8083:8083 \
  -p 80:80 \
  --restart unless-stopped \
  -e TITLE=$SERVICE \
  -v $HOME/.mosquitto:/mosquitto \
  -v $HOME/.mosquitto/config/mosquitto.conf:/mosquitto/config/mosquitto.conf \
  eclipse-mosquitto

