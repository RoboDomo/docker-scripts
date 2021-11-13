#!/bin/sh


export docker_parameters=" -d --log-opt max-size=10m --log-opt max-file=5 \
  --restart unless-stopped \
  --name $SERVICE \
  -e MQTT_HOST=$MQTT_HOST\
  -e MONGO_URL=$MONGO_URL \
  -e ROBODOMO_MONGODB=$MONGO_URL \
  -e TITLE=$SERVICE \
"
# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

stop() {
  echo "stopping $SERVICE"
  docker stop $SERVICE

  echo "removing old $SERVICE"
  docker rm $SERVICE
}

function pull() {
  echo "pulling $SERVICE"
  docker pull robodomo/$SERVICE
}

function start() {
  echo "starting new $SERVICE"
  if [[ $verbose == 1 ]]; then
    echo "docker run $docker_parameters$@ robodomo/$SERVICE"
  fi
  docker run $docker_parameters $@ robodomo/$SERVICE
  exit
}

if [[ -e "./lib/custom.sh" ]]; then
  . ./lib/custom.sh
fi
