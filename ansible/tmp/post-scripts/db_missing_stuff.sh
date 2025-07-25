#!/bin/bash

CUR_DIR=$PWD
cd $DRIVE_DIR
#add missing indexes
echo '##adding missing indexes to the database'
sudo -u www-data php occ db:add-missing-indices

#convert some columns to bigint  in database
echo '##adding missing columns in database'
sudo -u www-data php occ -n db:convert-filecache-bigint

cd $CUR_DIR
