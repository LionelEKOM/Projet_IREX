

USER_ADMIN="admin"
PASSWORD_ADMIN="pass"
REDIRECTURIS="https://drive.dev.onesi.ca/*"
cat<< EOF | tee create-client.sh
cd /opt/jboss/keycloak/bin
./kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user $USER_ADMIN --password $PASSWORD_ADMIN
./kcadm.sh create clients -r demorealm -s clientId=nextcloud -s enabled=true -s clientAuthenticatorType=client-secret   -s 'redirectUris=["$REDIRECTURIS"]'
EOF
docker cp create-client.sh keycloak-app:/tmp/create-client.sh
docker exec keycloak-app bash /tmp/create-client.sh
