#!/bin/bash

SERVICE=presence-microservice
. ./lib/common.sh

stop
pull
start
