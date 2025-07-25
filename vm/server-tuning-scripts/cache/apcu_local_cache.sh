#!/bin/bash

echo "###creating apcu conf.php file for local caching with basic configuration"
CONF_DIR="$DRIVE_DIR/config"
touch $CONF_DIR/cache.config.php
cat $CONF_DIR/config.php > $CONF_DIR/cache.config.php

echo "###adding apcu cache configurations"

sed -i "s/);/  'memcache.local' => '\\\OC\\\Memcache\\\APCu',\n);/g" $CONF_DIR/cache.config.php

#in order to not cause issues wigh nextcloud's cron jobs
source $PWD/server-tuning-scripts/cache/enable_apcu_for_php_cli.sh

echo "###End of apcu cache configuration"

