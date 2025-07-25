#!/bin/bash

echo $PWD

chmod +x $PWD/backend/install_php.sh
chmod +x $PWD/backend/install_nextcloud.sh

source $PWD/backend/install_php.sh
source $PWD/backend/install_nextcloud.sh
