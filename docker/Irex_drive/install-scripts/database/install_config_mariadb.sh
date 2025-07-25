#! /bin/bash

#Installation of MariaDB, We can use others like oracle 11g or PostgreSQL
#As root user
# apt install -y mariadb-server   

export MYSQL_OPTS="-uroot -p$MYSQL_ROOT_PASSWORD -h mariadb"
    echo "Securing mariadb server..."

    #Start MariaDB server
#    systemctl start mariadb
    echo "this is the current directory" $PWD
    #Secure the Mariadb instalation from OS repository
    echo "setting password for the root user"
    #mysql $MYSQL_OPTS -e "UPDATE mysql.user SET Password = PASSWORD('$DB_PASSWORD') WHERE User = 'root';"
    echo "removing anonymous-user accounts"
    mysql $MYSQL_OPTS -e "DELETE FROM mysql.user WHERE User='';"
    echo "removing root account that are accessible from outside the local host;"
    #mysql $MYSQL_OPTS -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    echo "deleting test database;"
    mysql $MYSQL_OPTS -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';"
    echo "applying changes;"
    mysql $MYSQL_OPTS -e "FLUSH PRIVILEGES"
    #fi

#Log into the MariaDB server with root user to create a database
#Create a database called 'nextclouddb'
#Grant access to nextclouddb to 'nextclouduser' and quit

#rootpass=password
echo "creating Nextcloud database..."
#mysql $MYSQL_OPTS -e "CREATE DATABASE $DB_NAME;"
echo "creating and granting permition to nextclouduser"
mysql $MYSQL_OPTS -e "GRANT ALL ON $DB_NAME.* to '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"


 echo "*** End of Mariadb configuration ***"
