#!/bin/bash

		###########################################
		#This is for smaller installations and if #
		#you don't need a separate cache          #
		###########################################

cat >> /etc/mysql/conf.d/mysql.cnf << EOF

[mysqld]
innodb_buffer_pool_size=$MYSQL_BUFFER_SIZE
innodb_io_capacity=$INNODB_IO_CAPACITY
EOF
