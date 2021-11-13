#!/bin/bash

declare -A services
services[appletv-microservice]=robodomo
services[autelis-microservice]=robodomo
services[bravia-microservice]=robodomo
services[collector-microservice]=nuc1
services[config-microservice]=robodomo
services[denon-microservice]=robodomo
services[harmony-microservice]=robodomo
services[here-microservice]=robodomo
services[hubitat-microservice]=nuc1
services[icomfort-microservice]=robodomo
services[lgtv-microservice]=robodomo
services[macro-microservice]=robodomo
services[macros-microservice]=robodomo
services[mongodb]=nuc1
services[eclipse-mosquitto]=nuc1
services[mosca]=DISABLED
services[myq-microservice]=robodomo
services[nest-microservice]=robodomo
services[presence-microservice]=robodomo
services[pyatv-microservice]=robodomo
services[react-client]=DISABLED
services[ring-microservice]=robodomo
services[samsung-microservice]=robodomo
services[mqtt-bridge]=robodomo
services[sysinfo-microservice]=ALL
services[tivo-microservice]=DISABLED
services[triggers-microservice]=nuc1
services[tvguide-microservice]=DISABLED
services[weather-microservice]=DISABLED
#services['collector-microservice']='nuc1'

service_host=${services[$SERVICE]}

if [[ $service_host == 'ALL' ]]; then
  return
fi

if [ $service_host == "" ] || [ $service_host == "DISABLED" ]; then
  echo "*** Service $SERVICE is DISABLED, stopping..."
  docker stop $SERVICE >/dev/null 2>&1 && docker rm -f $SERVICE >/dev/null 2>&1
  exit 0
fi

if [[ "$service_host" == "$HOSTNAME" ]]; then
  return
fi

echo "*** Service $SERVICE should run on host" $service_host "stopping..."
docker stop $SERVICE >/dev/null 2>&1 && docker rm -f $SERVICE >/dev/null 2>&1
exit 0

