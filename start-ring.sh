#!/bin/bash

SERVICE=ring-microservice
. ./lib/common.sh

if [[ "$RING_TOKEN" == "" ]]; then
  echo "ENV variable RING_TOKEN is required but is not set.  See start-ring.sh for more details"
  exit 1
fi

stop
pull
start -e RING_TOKEN=$RING_TOKEN 

