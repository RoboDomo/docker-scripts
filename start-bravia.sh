#!/bin/bash

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of Sony/Bravia TV hostnames/IP addresses that are to be controlled by
# this microservice
# BRAVIA_HOSTS=bravia1,bravia2,...

SERVICE=bravia-microservice
. ./lib/common.sh

if [[ "$BRAVIA_HOSTS" == "" ]]; then
  echo "ENV variable BRAVIA_HOSTS is required but is not set.  See start-bravia.sh for more details"
  exit 1
fi

stop
pull

start "-e BRAVIA_HOSTS='$BRAVIA_HOSTS'"

