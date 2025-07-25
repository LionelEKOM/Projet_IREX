#!/bin/bash
echo '##tuning php-fpm'

CONF_PATH="/etc/php/$PHP_VERSION/fpm/pool.d/www.conf"

sed -i 's/pm =.*/pm = dynamic/' $CONF_PATH
sed -i "s/pm.max_children.*/pm.max_children = $MAX_PROCESS_CHILDREN/" $CONF_PATH
sed -i "s/pm.start_servers.*/pm.start_servers = $PROCESS_ON_START/" $CONF_PATH
sed -i "s/pm.min_spare_servers.*/pm.min_spare_servers = $MIN_IDLE_PROCESS/" $CONF_PATH
sed -i "s/pm.max_spare_servers.*/pm.max_spare_servers = $MAX_IDLE_PROCESS/" $CONF_PATH
