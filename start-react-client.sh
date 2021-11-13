#!/bin/bash


SERVICE=react-client
. ./lib/common.sh

stop
pull
start
echo "stopping $SERVICE"

hn=`hostname`
echo ""
echo ""
echo "Point your browser at:"
echo "http://$hn:8000"
echo ""
echo ""

