#!/bin/bash

./start-mongodb.sh
./start-mqtt.sh
./start-config.sh

sleep 2   # give config-microservice enough time to start up

./start-here.sh
./start-tvguide.sh
./start-autelis.sh
./start-tivo.sh
./start-denon.sh
./start-harmony.sh
./start-smartthings.sh
./start-bravia.sh
./start-lgtv.sh
./start-appletv.sh
./start-nest.sh
./start-macros.sh
./start-triggers.sh

# THIS MUST BE LAST AND YOU PROBABLY WANT TO LEAVE IT AS-IS
./start-react-client.sh

