#!/bin/bash

SERVICE=tvguide-microservice
. ./lib/common.sh

#### ENV VARS

# You can set these in this script (uncomment and edit the lines) or set them in your .zshrc/.bashrc/etc.

# TV Guide information is provided by SchedulesDirect.com.  You will need to pay/subscribe to their service
# (currently $25/year).  You will need to get the TV Guide ID(s) from which you want information available to
# RoboDomo.  For example, you might have two homes, two different cable TV providers, etc.  

# Set your SchedulesDirect username and password here.  For security reasons, instead, you should set these
# environment variables outside of this script or any script (or file) that is committed to a repository.
#TVGUIDE_USERNAME={username}
#TVGUIDE_PASWORD={password}

# Set your SchedulesDirect Guide IDs here (separated by commas if you want more than one).
#TVGUID_IDS={guide_id,guide_id...}

#### /ENV VARS

if [[ "$TVGUIDE_USERNAME" == "" || "$TVGUIDE_PASSWORD" == "" || "$TVGUIDE_IDS" = "" ]]; then
  echo "The environment varables TVGUIDE_USERNAME, TVGUIDE_PASSWORD, and TVGUIDE_IDS must be set.  See start-tvguid.sh for details."
  exit 1
fi

stop
pull
start -e "TVGUIDE_USERNAME=$TVGUIDE_USERNAME" -e "TVGUIDE_PASSWORD=$TVGUIDE_PASSWORD" -e "TVGUIDE_IDS=$TVGUIDE_IDS"

