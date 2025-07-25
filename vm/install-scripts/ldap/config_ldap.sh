#!/bin/bash


echo "this is the pwd in the ldap_config_file" $PWD

CUR_DIR=$PWD
cd $DRIVE_DIR

#echo "chose the user"
#sudo -u www-data 

echo "configuring first time logging infos"
sudo -u www-data php  occ maintenance:install --database $DB --database-name $DB_NAME  --database-user $DB_USER_NAME --database-pass $DB_PASSWORD --admin-user $ADMIN_LOG --admin-pass $ADMIN_PASS --data-dir $DATA_DIR

echo "setting the trusted domains"
sudo -u www-data php occ config:system:set trusted_domains $LINE_NUMBER --value=$DOMAIN_NAME

echo "### enabling ldap user and group backend app"
sudo -u www-data php  occ app:enable user_ldap

echo "creating config..."
sudo -u www-data php  occ ldap:create-empty-config

echo "setting AgentName..."
sudo -u www-data php  occ ldap:set-config s01 ldapAgentName  $SERVICE_ACCOUNT

echo "setting AgentPassword..."
sudo -u www-data php  occ ldap:set-config s01 ldapAgentPassword $PASSWORD

echo "setting Port..."
sudo -u www-data php  occ ldap:set-config s01 ldapPort $PORT

echo "setting Base..."
sudo -u www-data php  occ ldap:set-config s01 ldapBase $BASEDN

#echo "setting BaseUsers..."
#sudo -u www-data php  occ ldap:set-config s01 ldapBaseUsers $BASEDNUSER

#echo "setting BaseGroups..."
#sudo -u www-data php  occ ldap:set-config s01 ldapBaseGroups $BASEDNGROUP
echo "setting GroupFilter..."
sudo -u www-data php  occ ldap:set-config s01 ldapGroupFilter $GROUPFILTER

echo "setting GroupFilterGroups..."
sudo -u www-data php  occ ldap:set-config s01 ldapGroupFilterGroups $GROUPFILTERGROUP

echo "setting Host..."
sudo -u www-data php  occ ldap:set-config s01 ldapHost $HOST

echo "setting LoginFilter..."
sudo -u www-data php  occ ldap:set-config s01 ldapLoginFilter $LOGINFILTER

echo "setting LoginFilterAttr..."
sudo -u www-data php  occ ldap:set-config s01 ldapLoginFilterAttributes $LOGINFILTERATTR

echo "setting LoginFilterEmail..."
sudo -u www-data php  occ ldap:set-config s01 ldapLoginFilterEmail $LOGINFILTEREMAILBOOLEAN

echo "setting LoginFilterUsername..."
sudo -u www-data php  occ ldap:set-config s01 ldapLoginFilterUsername $LOGINFILTERNAMEBOOLEAN

echo "Setting UserDisplayName..."
sudo -u www-data php  occ ldap:set-config s01 ldapUserDisplayName $USERDISPLAYNAME

#sudo -u www-data php  occ ldap:set-config s01 ldapUserDisplayName2 $USERDISPLAYNAME2

echo "Setting UserFilter..."
sudo -u www-data php  occ ldap:set-config s01 ldapUserFilter $USERFILTER

echo "setting userfilterobjectclass..."
sudo -u www-data php  occ ldap:set-config s01 ldapUserFilterObjectclass $USERFILTEROBJECTCLASS

echo "Activating the configuration"
sudo -u www-data php occ ldap:set-config s01 ldapConfigurationActive $CONFIGACTIVE

cd $CUR_DIR/../
