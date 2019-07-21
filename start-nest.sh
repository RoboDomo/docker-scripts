#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to be your Nest authorization key.  You get your key by creating an account at
# https://developers.nest.com.  A howto for obtaining the key can be found here: 
# https://www.digitalsanctuary.com/general/control-your-nest-thermostat-from-the-command-line.html.
#
# The README in the RoboDomo/nest-microservice repository is also useful.

# It is more secure to set this environment variable in some script (.zshrc/.bashrc/etc.) that is never
# committed to any repository.
# The autorization key looks something like c.xasdfafasfd...
# NEST_AUTH="long nest autorization key" 

### /ENV VARS

if [[ "$NEST_AUTH" == "" ]]; then
  echo "NEST_AUTH environment variable is required.  See start-nest.sh for more details."
  exit 1
fi

SERVICE=nest-microservice

echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull robodomo/$SERVICE

echo "starting new $SERVICE"
docker rm $SERVICE
docker run \
    -d \
    --restart always \
    --name $SERVICE \
    -e MQTT_HOST=$MQTT_HOST \
    -e NEST_AUTH=$NEST_AUTH \
    -e TITLE=$SERVICE \
    robodomo/$SERVICE

