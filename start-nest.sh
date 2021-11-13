#!/bin/bash

SERVICE=nest-microservice
. ./lib/common.sh

#### ENV VARS

# Change this to be your Nest authorization key.  You get your key by creating an account at
# https://developers.nest.com.  A howto for obtaining the key can be found here: 
# https://www.digitalsanctuary.com/general/control-your-nest-thermostat-from-the-command-line.html.
#
# The README in the RoboDomo/nest-microservice repository is also useful.

# It is more secure to set this environment variable in some script (.zshrc/.bashrc/etc.) that is never
# committed to any repository.
# The autorization key looks something like c.xasdfafasfd...
# NEST_AUTH="long nest autorization key" 

### /ENV VARS

if [[ "$NEST_AUTH" == "" ]]; then
  echo "NEST_AUTH environment variable is required.  See start-nest.sh for more details."
  exit 1
fi

stop
pull
start -e NEST_AUTH=$NEST_AUTH 

