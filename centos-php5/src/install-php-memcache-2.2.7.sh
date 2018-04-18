#!/bin/bash
set -e

cd /data/src 
/usr/local/php-5.4.43/bin/pecl download memcache-2.2.7
tar -zxvf memcache-2.2.7.tgz
cd memcache-2.2.7
/usr/local/php-5.4.43/bin/phpize
./configure \
  --with-php-config=/usr/local/php-5.4.43/bin/php-config
make 
make install
echo "extension=mongodb.so" >> /usr/local/php-5.4.43/lib/php.ini

cd /data/src 
rm -rf memcache-2.2.7
