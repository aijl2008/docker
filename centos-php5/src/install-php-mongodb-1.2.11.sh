#!/bin/bash
set -e

cd /data/src 
/usr/local/php-5.4.43/bin/pecl download mongodb-1.2.11
tar -zxvf mongodb-1.2.11.tgz
cd mongodb-1.2.11
/usr/local/php-5.4.43/bin/phpize
./configure \
  --with-php-config=/usr/local/php-5.4.43/bin/php-config
make 
make install
echo "extension=mongodb.so" >> /usr/local/php-5.4.43/lib/php.ini

cd /data/src 
rm -rf mongodb-1.2.11
