#!/bin/bash

SERVICE=myq-microservice
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Set this to a comma separated list of AVR hostnames/IP addresses that are to be controlled by
# this microservice
# MYQ_HOSTS=myq1,myq2,...

#### /ENV VARS

stop
pull
start -e MYQ_EMAIL=$MYQ_EMAIL -e MYQ_PASSWORD=$MYQ_PASSWORD 

