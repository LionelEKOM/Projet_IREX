#!/bin/bash
echo "##enabling apcu for php_cli"
cat >> /etc/php/$PHP_VERSION/cli/conf.d/20-acpu.ini << EOF
apc.enable_cli = 1
EOF
