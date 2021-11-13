#!/bin/bash

SERVICE=denon-microservice
. ./lib/common.sh

if [[ "$DENON_HOSTS" == "" ]]; then
  echo "ENV variable DENON_HOSTS is required but is not set.  See start-denon.sh for more details"
  exit 1
fi

stop
pull
start -e DENON_HOSTS=$DENON_HOSTS 

