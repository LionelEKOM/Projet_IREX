#!/bin/bash

echo "key and cert generation"
echo $PWD

#Generation of the key
openssl genrsa -aes256 -passout pass:$PASSWORD -out $DOMAIN_NAME.key 4096

#Remove pem phrase from the key
openssl rsa -in ./$DOMAIN_NAME.key -passin pass:$PASSWORD -out $DOMAIN_NAME.key

#Create a certificate
openssl req -key ./$DOMAIN_NAME.key -new -x509 -days 365 -out $DOMAIN_NAME.crt -passin pass:$PASSWORD -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORGANIZATIONALUNIT/CN=$DOMAIN/emailAddress=$EMAIL"

#copy cert and key to the right directory
mv ./$DOMAIN_NAME.key /etc/ssl/nginx/
mv ./$DOMAIN_NAME.crt /etc/ssl/nginx/

service nginx restart
