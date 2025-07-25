#!/bin/sh

W_CONF_PATH="/etc/php/$PHP_VERSION/fpm/pool.d/www.conf"
PHP_INI_PATH="/etc/php/$PHP_VERSION/fpm/php.ini"

#setup php to query system environment variables
sed -i "s/;clear_env = .*/clear_env = no/g" $W_CONF_PATH

#setup the php memory limit to recommended value
sed -i "s/memory_limit = .*/memory_limit = $MEM_LIMIT/g" $PHP_INI_PATH

#setup php max upload file size
sed -i "s/max_upload_filesize = .*/max_upload_filesize = $MAX_UPLOAD_FILESIZE/g" $PHP_INI_PATH

#setup php post data size
sed -i "s/post_max_size = .*/post_max_size = $POST_MAX_SIZE/g" $PHP_INI_PATH

echo "##enable SVG for php imagick"
apt-get install -y libmagickcore-6.q16-6-extra

sleep 10

echo "##set the default phone region"
CUR_DIR=$PWD
cd $DRIVE_DIR
sudo -u www-data php occ config:system:set default_phone_region --value=$PHONE_REGION
cd $CUR_DIR
