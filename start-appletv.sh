#!/bin/bash

SERVICE=appletv-microservice
. ./lib/common.sh

stop
pull
start

