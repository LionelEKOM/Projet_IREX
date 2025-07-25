#Build stage for driveBackend

FROM debian:buster AS drive

LABEL maintainer="anassara <anassara@irex.aretex.ca>"

#ARG SCRIPTS_LOCATION

ARG FRONTEND_LOCATION

ARG BACKEND_LOCATION

ARG DEFAULTS_CONF_LOCATION

ARG PHP_VERSION=7.4

ARG NEXTCLOUD_VERSION=22.2.0

RUN # Update package lists

RUN apt-get -y update && apt-get install -y systemd sudo wget tar unzip sed coreutils \
                         gnupg2 lsb-release ca-certificates apt-transport-https

RUN #install php

RUN wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php$PHP_VERSION.list 

RUN apt-get update -y && apt-get install -y php$PHP_VERSION php$PHP_VERSION-bcmath php$PHP_VERSION-gmp \
     php$PHP_VERSION-fpm php$PHP_VERSION-gd php$PHP_VERSION-json \
     php$PHP_VERSION-ldap php$PHP_VERSION-mysql php$PHP_VERSION-curl \
     php$PHP_VERSION-mbstring php$PHP_VERSION-intl \
     php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-sqlite3 \
     php$PHP_VERSION-imagick php$PHP_VERSION-common

RUN sed -i -r "s/listen = \/run\/php\/php$PHP_VERSION-fpm.sock/listen = 9000/g" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf

#Add volume for nextcloud

VOLUME /tmp 

RUN #install nextcloud 

RUN wget https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.tar.bz2  \
    && tar -jxvf nextcloud-$NEXTCLOUD_VERSION.tar.bz2 


#Open port
EXPOSE 9000 443 80

#Add scripts for installation

#COPY ./$SCRIPTS_LOCATION .

COPY ./$FRONTEND_LOCATION ./$FRONTEND_LOCATION

COPY ./$BACKEND_LOCATION ./$BACKEND_LOCATION
 

#Add conf for installation

#ADD ./$DEFAULTS_CONF_LOCATION /conf

COPY ./$DEFAULTS_CONF_LOCATION /conf

#CMD tail -f /dev/null

CMD service php7.4-fpm start && cp -r nextcloud /tmp && tail -f /dev/null
#ENTRYPOINT ["./main.sh"]
