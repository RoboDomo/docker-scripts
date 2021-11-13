#!/bin/bash

SERVICE=samsung-microservice
. ./lib/common.sh


stop
pull
start --net-host

