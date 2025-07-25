#!/bin/bash

#configure redis to match nextcloud conf

REDIS_CONF_PATH='/etc/redis/redis.conf'
sed -i "s/port 6379/port $REDIS_PORT/g" $REDIS_CONF_PATH

sed -i "s+# unixsocket /.*+unixsocket $REDIS_HOST+g" $REDIS_CONF_PATH

sed -i "s/# unixsocketperm .*/unixsocketperm $SOCKET_PERM/g" $REDIS_CONF_PATH

