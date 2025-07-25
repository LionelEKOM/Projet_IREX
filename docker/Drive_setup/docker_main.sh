#!/bin/bash


WORK_DIR=$(pwd)

#Build the drivesetup image
docker build -t drivesetup --build-arg ENTRYPOINT_LOCATION=drive_setup.sh -f $WORK_DIR/Dockerfile .
 
#Run the drivesetup image
#docker run -itd --name drivesetup  -v ../Irex_drive:/nextcloud drivesetup
