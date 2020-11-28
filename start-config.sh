#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

SERVICE=config-microservice

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
    -v $PWD/config:/home/app/config \
    -v /home/app/node_modules \
    --restart always \
    --name $SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e MONGO_URL=$MONGO_URL \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

echo ""
echo ""
echo "Your configuration files are here:"
echo "ls -l config"
ls -l config
echo "Edit config/Config.js and config/Macros.js to suit your needs.  Make backups of each so you will never lose your work!"
echo ""
echo "The files should not be overwritten by this microservice."
echo ""
echo "Whenever you edit either file, it will be reread and loaded into mongodb.  The clients should reload automatically to"
echo "deal with the config changes."

