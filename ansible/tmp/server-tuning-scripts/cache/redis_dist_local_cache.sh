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

cat >> $CONF_DIR/cache.config.php << EOF
  'memcache.local' => '\\OC\\Memcache\\Redis',
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'redis' => [
       'host'     => '$REDIS_HOST',
       'port'     => $REDIS__PORT,
       'password' => '$REDIS_PASS',
       'timeout'  => $TIMEOUT,
       'dbindex'  => $DB_INDEX,
  ],
);
EOF

#set the right permissions on redis.sock
usermod -a -G redis www-data

echo "###End of redis cache configuration"

