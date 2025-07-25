#!/bin/bash

WORKDIR=$(pwd)

source $WORKDIR/nextcloud/conf.defaults

apt-get -y install netcat


# dans le entrypoint.sh du mysql-setup ou drive-setup
echo 'Using MysQL'
DB_PORT=${MYSQL_PORT:-'3306'}
DB_URL="jdbc:${DB}://${MYSQL_HOST}:${MYSQL_PORT}/$MYSQL_DATABASE"

until nc -zv -w 5 ${MYSQL_HOST} ${MYSQL_PORT}; do echo "waiting for mysql service..."; sleep 2; done;

if ! mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE -e "SELECT 1 FROM information_schema.tables WHERE table_schema = '$MYSQL_DATABASE' AND table_name = 'ISSUE';" | grep 1 ; then
    echo 'Initializing MySQL database'
    #mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < ../database-scripts/mysql-full-install-version-$SQUASH_TM_VERSION.RELEASE.sql
else
    echo 'Database already initialized'
fi


while [[ -z $(printf "GET / HTTP/1.0\r\n\r\n" | nc $DOMAIN_NAME $DRIVE_NGINX_PORT) ]]; 
do 
  echo "drive nginx not started yet! about to sleep for 10 s";
  
  sleep 10;
done;

echo "viewing the default page ..."

printf "GET / HTTP/1.0\r\n\r\n" | nc $DOMAIN_NAME $DRIVE_NGINX_PORT

echo "sending the drive conf script into the drive"

sshpass -p drive scp -o 'StrictHostKeyChecking=no' -P $DRIVE_SSH_PORT -r  nextcloud/ root@$DOMAIN_NAME:/

echo"launch script for configuration"

sshpass -p drive ssh -p $DRIVE_SSH_PORT root@$DOMAIN_NAME "cd /nextcloud && bash main.sh"
