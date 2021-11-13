#!/bin/bash

SERVICE=lgtv-microservice
. ./lib/common.sh

if [[ "$LGTV_HOSTS" == "" ]]; then
  echo "ENV variable LGTV_HOSTS is required but is not set.  See start-lgtv.sh for more details"
  exit 1
fi

stop
pull
run --net=host -e LGTV_HOSTS=$LGTV_HOSTS -v ~/.lgtv2:/home/app/.lgtv2 

