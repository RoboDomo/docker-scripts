#!/bin/bash

SERVICE=triggers-microservice
. ./lib/common.sh

#### ENV VARS


# Set this to the number of milliseconds that the bathroom fans should remain on
TIMEOUT=600000

#### /ENV VARS

stop
pull
start -e TIMEOUT=$TIMEOUT 

