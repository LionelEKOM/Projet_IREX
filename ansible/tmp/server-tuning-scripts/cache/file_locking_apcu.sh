#!/bin/bash

#install redis and it's php dependency
chmod +x $PWD/server-tuning-scripts/cache/install_redis.sh
source $PWD/server-tuning-scripts/cache/install_redis.sh

echo "###creating redis conf.php file for distributed caching with basic configuration"
CONF_DIR="$DRIVE_DIR/config"
touch $CONF_DIR/cache.config.php
cat $CONF_DIR/config.php > $CONF_DIR/cache.config.php

echo "###adding redis cache configurations"

sed -i 's/);//g' $CONF_DIR/cache.config.php

cat >> $CONF_DIR/cahe.config.php << EOF
  'filelocking.enabled' => true,
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' => array(
       'host'     => '$REDIS_HOST',
       'port'     => $REDIS_PORT,
       'password' => '$REDIS_PASS',
       'timeout'  => $TIMEOUT,
       'dbindex'  => $DB_INDEX,
  ),
);
EOF

#set the right permission on redis.sock
usermod -a -G redis www-data

#in order to not cause issues with nextcloud's cron jobs
source $PWD/server-tuning-scripts/cache/enable_apcu_for_php_cli.sh

echo "###End of redis file locking configuration"

