#!/bin/bash

SERVICE=tivo-microservice
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of TiVo hostnames/IP addresses that are to be controlled by
# this microservice
# TIVO_HOSTS=bolt1,mini1,mini2,...

#### /ENV VARS

if [[ "$TIVO_HOSTS" == "" ]]; then
  echo "ENV variable TIVO_HOSTS is required but is not set.  See start-tivo.sh for more details"
  exit 1
fi

stop
pull
start -e TIVO_HOSTS="$TIVO_HOSTS" 

