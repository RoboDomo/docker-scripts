#!/bin/bash

#### ENV VARS

SERVICE=autelis-microservice
. ./lib/common.sh

stop
pull
start

