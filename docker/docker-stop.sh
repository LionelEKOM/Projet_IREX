#!/bin/bash

DOCKER_COMPOSE_PATH=$1

if [ -z $DOCKER_COMPOSE_PATH ]

then
 
 export DOCKER_COMPOSE_PATH="$HOME/nextcloud/docker/";

fi

echo "DOCKER_COMPOSE_PATH=$DOCKER_COMPOSE_PATH"

echo "Stopping of docker compose"

pushd $DOCKER_COMPOSE_PATH

docker-compose stop

popd
