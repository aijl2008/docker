#!/bin/bash
set -e

cd /data/src 
/usr/local/php-7.1.13/bin/pecl download mongodb-1.4.2
tar -zxvf mongodb-1.4.2.tgz
cd mongodb-1.4.2
/usr/local/php-7.1.13/bin/phpize
./configure \
  --with-php-config=/usr/local/php-7.1.13/bin/php-config
make 
make install
echo "extension=mongodb.so" >> /usr/local/php-7.1.13/lib/php.ini


cd /data/src 
rm -rf mongodb-1.4.2
