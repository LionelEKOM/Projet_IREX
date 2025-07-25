#!/bin/bash

apt install -y python-pip
apt-get install -y python-dev
pip install 'glances[action,browser,cloud,cpuinfo,folders,export,folders,gpu,graph,ip,raid,snmp,web,wifi]'
