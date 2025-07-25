#!/bin/bash

echo "cleaning the drive and drivesetup containers"

docker rm drive

docker rm drivesetup

docker rm mariadb
