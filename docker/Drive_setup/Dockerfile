#Build stage for drive

FROM debian:buster AS drive_setup

LABEL maintainer="anassara <anassara@irex.aretex.ca>"

ARG ENTRYPOINT_LOCATION="Drive_setup"
ARG MARIADB_VERSION="10.3"
#Update package lists

RUN apt-get -y update --allow-releaseinfo-change -y \
   && apt-get install --no-install-recommends --no-install-suggests -q -y systemd \
 sudo wget tar unzip sed coreutils \
 gnupg2 lsb-release ca-certificates apt-transport-https \
 python-pip python-setuptools zip git libmemcached-dev \
 libmemcached11 libmagickwand-dev nano vim openssh-client mariadb-client-$MARIADB_VERSION sed sshpass
# Clean cache

RUN \
 apt-get autoremove -y && \
 apt-get clean -y all

#Copy entrypoint script
ADD ./$ENTRYPOINT_LOCATION /drive_setup.sh

#Create nextcloud directory 
RUN mkdir nextcloud 

ENTRYPOINT ["./drive_setup.sh"]

