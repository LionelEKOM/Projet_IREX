#!/bin/bash

#we are using systemd here
cat > /etc/systemd/system/nextcloudcron.service << EOF
[Unit]
Description=Nextcloud cron.php job

[Service]
User=www-data
ExecStart=/usr/bin/php -f $DRIVE_DIR/cron.php

EOF

cat > /etc/systemd/system/nextcloudcron.timer << EOF
[Unit]
Description=Run Nextcloud cron.php every 5 minutes

[Timer]
OnBootSec=5min
OnUnitActiveSec=5min
Unit=nextcloudcron.service

[Install]
WantedBy=timers.target

EOF

#enable timer to start
#systemctl enable --now nextcloudcron.timer

