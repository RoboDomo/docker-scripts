#!/bin/bash

SERVICE=config-microservice
. ./lib/common.sh

stop
pull
start -v $PWD/config:/home/app/config -v /home/app/node_modules

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

