#!/bin/bash
SERVICE=nest-microservice


echo "stopping $SERVICE"
docker stop $SERVICE

echo "removing old $SERVICE"
docker rm $SERVICE

echo "starting new $SERVICE"
docker rm $SERVICE
docker run \
    -d \
    --restart always \
    --name $SERVICE \
    -e NEST_AUTH=c.w8Bac8dXDIOoI6hg9h9BZZUJHziT5u5MUPXyxicIUiY9OnnUUrHM9VlDId4HCTNsTDyj4eR2TaI6YA6CXe1Z4uQ9jWDBG7mnURa00yxHjy26cFwTIc0lQzsMFDhpD2DwOs1lo5AwNYsZnsTp \
    robodomo/$SERVICE

