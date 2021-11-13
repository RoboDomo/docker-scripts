#!/bin/bash

SERVICE=macro-microservice
. ./lib/common.sh

stop
pull
start

echo ""
echo ""
echo ""
echo "You can edit config/Macros.js to add or change your macros."
echo "They will automatically be loaded/reloaded when the file is changed/saved."

