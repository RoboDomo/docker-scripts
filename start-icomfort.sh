#!/bin/bash

SERVICE=icomfort-microservice
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

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

if [[ "$LENNOX_USER" == "" ]]; then
  echo "LENNOX_USER environment variable is required.  See start-icomfort.sh for more details."
  exit 1
fi
if [[ "$LENNOX_PASSWORD" == "" ]]; then
  echo "LENNOX_PASSWORD environment variable is required.  See start-icomfort.sh for more details."
  exit 1
fi
if [[ "$LENNOX_HOMEID" == "" ]]; then
  echo "LENNOX_HOMEID environment variable is required.  See start-icomfort.sh for more details."
  exit 1
fi
if [[ "$LENNOX_LCCID" == "" ]]; then
  echo "LENNOX_LCCID environment variable is required.  See start-icomfort.sh for more details."
  exit 1
fi

stop
pull
start -e LENNOX_USER=$LENNOX_USER -e LENNOX_PASSWORD=$LENNOX_PASSWORD -e LENNOX_HOMEID=$LENNOX_HOMEID -e LENNOX_LCCID=$LENNOX_LCCID 

