#!/bin/bash


#Installation of Nextcloud
#Download Nextcloud
 cur_dir=$PWD
 cd /tmp/
 wget https://download.nextcloud.com/server/releases/latest-$VERSION.tar.bz2
 tar -jxvf latest-$VERSION.tar.bz2
 mv nextcloud $WEB_ROOT
 mkdir $DRIVE_DIR/data
 cd $cur_dir
 cd ..
# echo $PWD
# Give the ownership to the Apache user so that they can write into
# the nextcloud directory
 sudo chown -R www-data:www-data $DRIVE_DIR/

 echo "** End of nextcloud installation **"
