#!/bin/bash

#./start-mongodb.sh
#./start-mqtt.sh
./start-config.sh

sleep 2   # give config-microservice enough time to start up

./start-appletv.sh
./start-autelis.sh
./start-bravia.sh
./start-collector.sh
./start-denon.sh
./start-harmony.sh
./start-here.sh
./start-hubitat.sh
./start-icomfort.sh
./start-lgtv.sh
./start-macros.sh
./start-mongodb.sh
./start-mosca.sh
./start-mosquitto.sh
./start-myq.sh
./start-nest.sh
./start-presence.sh
./start-pyatv.sh
./start-ring.sh
./start-samsung.sh
./start-smartthings.sh
./start-sysinfo.sh
./start-tivo.sh
./start-triggers.sh
./start-tvguide.sh
./start-weather.sh

# THIS MUST BE LAST AND YOU PROBABLY WANT TO LEAVE IT AS-IS
./start-react-client.sh

