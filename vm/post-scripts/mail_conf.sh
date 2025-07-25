#!/bin/bash
CUR_DIR=$PWD
cd $DRIVE_DIR

echo "##Configuring mail server"

sudo -u www-data php occ config:system:set mail_smtpmode --value=$MAIL_MODE

sudo -u www-data php occ config:system:set mail_smtphost --value=$MAIL_SERVER

sudo -u www-data php occ config:system:set mail_smtpport --value=$MAIL_PORT

sudo -u www-data php occ config:system:set mail_from_address --value=$MAIL_TEST_NAME

sudo -u www-data php occ config:system:set mail_domain --value=$MAIL_SERVER_DOMAIN

sudo -u www-data php occ config:system:set mail_smtpsecure --value=$MAIL_SECURE

sudo -u www-data php occ config:system:set mail_smtptimeout --value=$MAIL_TIMEOUT

if [[ -n $MAIL_AUTH ]]; then
  sudo -u www-data php occ config:system:set mail_smtpauth --value=$MAIL_AUTH
  sudo -u www-data php occ config:system:set mail_smtpauthtype --value=$MAIL_AUTH_TYPE
  sudo -u www-data php occ config:system:set mail_smtpname --value=$MAIL_NAME
  sudo -u www-data php occ config:system:set mail_smtppassword --value=$MAIL_PASSWD
fi

sudo -u www-data php occ config:system:set mail_smtpdebug --value=$MAIL_DEBUG

sudo -u www-data php occ user:setting admin settings email "$MAIL_ADMIN"

echo "##End of mail configuration"

cd $CUR_DIR
