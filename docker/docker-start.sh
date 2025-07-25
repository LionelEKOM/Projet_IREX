#!/bin/bash

DOCKER_COMPOSE_PATH=$1

echo "Run bash docker-start $YOUR_DOCKER_COMPOSE_PATH"

if [ -z $DOCKER_COMPOSE_PATH ]

then

 export DOCKER_COMPOSE_PATH="$HOME/nextcloud/docker";

fi

if [ -z $MARIADB_VOLUME_PATH ]

then 
 
  export  MARIADB_VOLUME_PATH="$HOME/nextcloud/docker/mariadb/data";

fi


echo "Check if Maridadb external folder exist and create it if not "

if [ ! -d $MARIADB_VOLUME_PATH ]

then 

  echo "Mariadb external volume  $MARIADB_VOLUME_PATH does not exists.... creation"

  mkdir -p  $MARIADB_VOLUME_PATH

fi

echo "docker_drive network creation"

#docker network create docker_drive

echo "DOCKER_COMPOSE_PATH=$DOCKER_COMPOSE_PATH"

echo "docker compose starting"

docker-compose -f $DOCKER_COMPOSE_PATH/docker-compose.yml up -d

echo "follow the logs, ctrl+c to quit"

echo "cd $DOCKER_COMPOSE_PATH && docker-compose logs -f # This must help you to follow logs"
