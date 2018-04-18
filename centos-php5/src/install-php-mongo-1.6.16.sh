#!/bin/bash
set -e

cd /data/src 
/usr/local/php-5.4.43/bin/pecl download mongo-1.6.16
tar -zxvf mongo-1.6.16.tgz
cd mongo-1.6.16
/usr/local/php-5.4.43/bin/phpize
./configure \
  --with-php-config=/usr/local/php-5.4.43/bin/php-config
make 
make install
echo "extension=mongodb.so" >> /usr/local/php-5.4.43/lib/php.ini


