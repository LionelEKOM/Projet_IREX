#!/bin/bash


WORK_DIR=$(pwd)

#Build the driveBackend image
docker build -t drive -f $WORK_DIR/Dockerfile .
 
#Run the drivebackend image
#docker run -itd --name drive -p 2222:22 -p 9000:9000 -p 8080:80 -p 443:443  -p 3306:3306 -p 6379:6379 -v /etc/letsencrypt/live:/etc/letsencrypt/live drive
