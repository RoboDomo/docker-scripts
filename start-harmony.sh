#!/bin/bash

SERVICE=harmony-microservice
. ./lib/common.sh

stop
pull
start

