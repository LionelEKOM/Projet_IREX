#!/bin/bash

#Installation of PHP $PHP_VERSION using SURY repository
#Nextcloud requies PHP 7.1 and above
#as root user
#Configuring SURY repository
 apt-get install -y gnupg2 lsb-release ca-certificates apt-transport-https
 wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
 echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php$PHP_VERSION.list
 
 apt-get update -y
#Installation of PHP and its extensions for NextCloud
#As root user
 apt-get install -y php$PHP_VERSION php$PHP_VERSION-bcmath php$PHP_VERSION-gmp \
 php$PHP_VERSION-fpm php$PHP_VERSION-gd php$PHP_VERSION-json \
 php$PHP_VERSION-ldap php$PHP_VERSION-mysql php$PHP_VERSION-curl \
 php$PHP_VERSION-mbstring php$PHP_VERSION-intl \
 php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-sqlite3 \
 php$PHP_VERSION-imagick php$PHP_VERSION-common

 echo "**** End PHP installation ****"
