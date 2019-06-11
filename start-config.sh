#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
MQTT_HOST="mqtt://robodomo"

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
    -v $PWD/config:/home/app/config \
    -v /home/app/node_modules \
    --restart always \
    --name $SERVICE \
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

