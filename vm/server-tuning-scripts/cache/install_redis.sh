#!/bin/bash

echo "installing redis and its php dependency"

PKG_REDIS="redis-server"
PKG_PHP="php-redis"
SERVICE="redis"
STATE="running"

#check redis and its dependency
if [ $(dpkg-query -W -f='${Status}' $PKG_REDIS 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "###redis-server is not installed"
  echo "###installing redis-server"
  apt-get install -y redis-server
  sysctl vm.overcommit_memory=1
fi

echo '##customizing redis.conf file'
source $PWD/server-tuning-scripts/cache/redis_conf.sh

if [ $(dpkg-query -W -f='${Status}' $PKG_PHP 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "###php-redis is not installed"
  echo "###installing php-reedis"
  apt-get -y install php$PHP_VERSION-redis
fi

if [ "$STATE" = $(systemctl show -p SubState --value $SERVICE) ];
then
  systemctl restart nginx
else
  systemctl start redis
  systemctl restart nginx
fi
systemctl enable redis-server

