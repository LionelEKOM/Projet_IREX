#!/bin/bash
	#####################################
	# Nextcloud installation bash script#
	#####################################

 chmod +x ./install-scripts/install_frontend.sh
 chmod +x ./install-scripts/install_backend.sh
 chmod +x ./install-scripts/install_database.sh
 chmod +x ./install-scripts/ldap/config_ldap.sh
 chmod +x ./server-tuning-scripts/cache/*
 chmod +x ./server-tuning-scripts/*
 chmod +x ./post-scripts/*
# chmod +x ./getclientcerts/*

 source conf.defaults
 
# source ./getclientcerts/getCertificates.sh
 source ./install-scripts/install_frontend.sh

 source ./install-scripts/install_backend.sh
 
 source ./install-scripts/install_database.sh
 
 source ./install-scripts/ldap/config_ldap.sh


echo '##performing post installation configurations'
 source ./post-scripts/setup_php.sh
 source ./post-scripts/db_missing_stuff.sh
 source ./post-scripts/mail_conf.sh
echo "##Customizing theme"
source ./post-scripts/custum_theme.sh

echo '##tuning the server' 
#default conf script
 source ./server-tuning-scripts/cron_job.sh
 
 source ./server-tuning-scripts/cache/enable_opcache.sh

 source ./server-tuning-scripts/tune_php-fpm.sh

 source ./server-tuning-scripts/cache/install_apcu.sh
 
#Optional configuration
if [[ $USE_GLANCE == 1 ]]
then 
 echo '##Installting glance'
 source ./server-tuning-scripts/install_glance.sh
fi

if [[ $REDIS_FOR_ALL == 1 ]]; then
 echo '##Configuring redis for all'
 source ./server-tuning-scripts/cache/redis_for_all.sh
elif [[ "$LOCAL_CACHE" == "apcu" && $DIST_CACHE == 1 && $FILE_LOCKING == 1 ]]; then
 echo '##Default cache, filelocking configuration'
 source ./server-tuning-scripts/cache/file_locking_dist_apcu_cache.sh
elif [[ "$LOCAL_CACHE" == "apcu" && $DIST_CACHE != 1 && $FILE_LOCKING != 1 ]]; then
 echo '##Configuring apcu for local cache'
 source ./server-tuning-scripts/cache/apcu_local_cache.sh
elif [[ "$LOCAL_CACHE" == "apcu" && $DIST_CACHE == 1 && $FILE_LOCKING != 1 ]]; then
 echo '##Configuring apcu for local cache and redis for distributed cache'
 source ./server-tuning-scripts/cache/redis_apcu_local_cache_conf.sh
elif [[ "$LOCAL_CACHE" == "redis" && $DIST_CACHE == 1 && $FILE_LOCKING != 1 ]]; then
 echo '##Configuring redis for local and distributed cache'
 source ./server-tuning-scripts/cache/redis_dist_local_cache.sh
elif [[ "$LOCAL_CACHE" == "redis" && $DIST_CACHE == 1 && $FILE_LOCKING == 1 ]]; then
 echo '##Configuring redis for all'
 source ./server-tuning-scripts/cache/redis_for_all.sh
elif [[ "$LOCAL_CACHE" == "apcu" && $DIST_CACHE != 1 && $FILE_LOCKING == 1 ]]; then
 echo '##Configuring apcu and filelocking'
 source ./server-tuning-scripts/cache/file_locking_apcu.sh
elif [[ "$LOCAL_CACHE" == "" && $DIST_CACHE == 1 && $FILE_LOCKING != 1 ]]; then
 echo '##Configuring distributed cache'	
 source ./server-tuning-scripts/cache/redis_dist_cache.sh
elif [[ "$LOCAL_CACHE" == "" && $DIST_CACHE == 1 && $FILE_LOCKING == 1 ]]; then
 echo '##Configuring distributed cache and file locking'
 source ./server-tuning-scripts/cache/file_locking_redis_cache.sh
else 
 echo '##Default cache, filelocking configuration'
 source ./server-tuning-scripts/cache/file_locking_apcu_cache.sh
fi

if [[ $TUNE_DB == 1 ]]; then
 echo '##tuning the database'
 source ./server-tuning-scripts/tune_db.sh
fi


#echo '##restarting the serving'
#systemctl start reboot.target

