#!/bin/bash

SERVICE=mongodb
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# Change this to an EXISTING directory on the HOST where the mongodb database files will be created and maintained.
MONGO_DATADIR="$HOME/data"

#### /ENV VARS

if [[ "$MONGO_DATADIR" == "" ]]; then
  echo "The MONGO_DATADIR environment variable must be set.  See start-mongodb.sh for details."
fi


echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "pulling $SERVICE"
docker pull mongo:3.4

docker run $docker_parameters -p 27017:27017 -v ~/data:/data/db mongo:3.6

