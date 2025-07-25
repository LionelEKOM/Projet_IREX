#!/bin/bash
echo '##configuring opcache'

INI_PATH="/etc/php/$PHP_VERSION/fpm/php.ini"

sed -i "s/;opcache.enable=.*/opcache.enable=$OP_ENABLE/" $INI_PATH
sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" $INI_PATH
sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=$STRING_BUFFER/" $INI_PATH
sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=$MAX_ACC_FILES/" $INI_PATH
sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=$MEM_CONSUMPTION/" $INI_PATH
sed -i "s/;opcache.save_comments=.*/opcache.save_comments=$SAVE_COMMENT/" $INI_PATH
sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=$REVALIDATE_FREQ/" $INI_PATH
sed -i "s/;opcache.fast_shutdown=.*/opcache.fast_shutdown=$FAST_SHUTDOWN/" $INI_PATH
sed -i "s/;opcache.validate_timestaps=.*/opcache.validate_timestaps=$VALIDATE_TIMESTAMPS/" $INI_PATH
