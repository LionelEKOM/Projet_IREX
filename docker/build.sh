#!/bin/bash


WORK_DIR=$(pwd)


#Build drive image 

cd $WORK_DIR/Irex_drive/ && bash docker_main.sh 2>&1 | tee ~/build_drive.log


#Build drivesetup image

#cd $WORK_DIR/Drive_setup/ &&  bash docker_main.sh 2>&1 | tee ~/build_drivesetup.log


cd $WORK_DIR
