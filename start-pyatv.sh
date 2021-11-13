#!/bin/bash

SERVICE=pyatv-microservice
. ./lib/common.sh

stop
pull
start --net=host

