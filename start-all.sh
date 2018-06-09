#!/bin/bash

docker run -d --restart always -p 1883:1883 -p 80:80 -v /var/db/mosca:/db matteocollina/mosca
