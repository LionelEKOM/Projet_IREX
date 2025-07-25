#!/bin/bash

INSTALL_DIR=$(pwd)

echo "creating logs dir in $INSTALL_DIR/logs"
mkdir -p $INSTALL_DIR/logs


echo "running and logging main_script.sh ..."
bash $INSTALL_DIR/main_script.sh 2>&1 | tee $INSTALL_DIR/logs/main_script.log

echo "done"
