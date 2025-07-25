#!/bin/bash

PWD=$PWD/install-scripts

apt-get upgrade -y

chmod +x  $PWD/frontend/install_nginx.sh
#chmod +x  $PWD/frontend/install_cert.sh

source $PWD/frontend/install_nginx.sh


