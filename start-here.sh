#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# At https://developer.here.com, register for a free account, then create a new JavaScript/REST
# application.  Set the assigned APP_ID and APP_CODE to the following variables:
#WEATHER_APP_ID={your_app_id}
#WEATHER_APP_CODE={your_app_code}

# Set the locations to be polled.  Location strings are explained at the here.com WWW site, but to get you going,
# you can use a string of the form: zipcode:valid_zip_code (e.g. zipcode:10001 for NYC), or of the form: city:city_name
# (e.g. city:London).  If you want to monitor two or more locations, separate the strings with comma 
# (e.g. zipcode:10001,city:London).
#WEATHER_LOCATIONS=zipcode:10001
# or
#WEATHER_LOCATIONS=zipcode:10001,city:London,...

# How often to poll for weather updates, in seconds.  The default (300) is 5 minutes.  There are 4 API requests made
# this often PER weather location.  You should calculate the number of API requests per month using your settings
# to assure you stay below the number API requests allowed for the free tier at here.com (currently 250,000 per month).
WEATHER_POLL_TIME=300

# Change this to match your MQTT broker hostname:
if [ "$MQTT_HOST" = "" ]; then
  MQTT_HOST="mqtt://mqtt"
fi

# Change this to match your MONGODB hostname:
if [ "$MONGO_URL" = "" ]; then
  MONGO_URL="mongodb://mongodb"
fi

#### /ENV VARS

SERVICE=here-microservice

if [[ "$WEATHER_LOCATIONS" == "" ]]; then
  echo "*** Error: WEATHER_LOCATIONS ENV variable not set.  Edit start-here.sh script for more details."
  exit 1
fi
if [[ "$WEATHER_APP_ID" == "" || "$WEATHER_APP_CODE" == "" ]]; then
  echo "*** Error: WEATHER_APP_ID and WEATHER_APP_CODE ENV variables must be set.  Edit start-here.sh script for more details."
  exit 1
fi

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
    -e MQTT_HOST=$MQTT_HOST \
    -e ROBODOMO_MONGODB=$MONGO_URL \
    -e WEATHER_LOCATIONS=$WEATHER_LOCATIONS \
    -e WEATHER_APP_ID=$WEATHER_APP_ID \
    -e WEATHER_APP_CODE=$WEATHER_APP_CODE \
    -e TITLE=$SERVICE \
    --restart always \
    --name $SERVICE \
    robodomo/$SERVICE

