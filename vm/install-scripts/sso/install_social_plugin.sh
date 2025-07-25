
CUR_DIR=$PWD
cd $DRIVE_DIR
sudo -u www-data php occ app:install sociallogin

sudo -u www-data php occ app:enable sociallogin

cat<< EOF | tee /tmp/sso.conf
{"custom_oidc": [
{
    "name": "$KEYCLOAK_CLIENT_NAME", 
    "title": "Drive onesi", 
    "authorizeUrl": "$KEYCLOAK_REAML/protocol/openid-connect/auth", 
    "tokenUrl": "$KEYCLOAK_REAML/protocol/openid-connect/token", 
    "userInfoUrl": "$KEYCLOAK_REAML/protocol/openid-connect/userinfo", 
    "logoutUrl": "", 
    "clientId": "$KEYCLOAK_CLIENT_ID", 
    "clientSecret": "$KEYCLOAK_CLIENT_PASSWORD", 
    "scope": "openid", 
    "groupsClaim": "groups", 
    "style": "keycloak", 
    "defaultGroup": ""
}]}
EOF
sudo -u www-data php occ config:app:set sociallogin custom_providers --value="$(cat /tmp/sso.conf)"


cd $CUR_DIR/../

