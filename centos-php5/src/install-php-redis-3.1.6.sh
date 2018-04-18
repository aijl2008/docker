#!/bin/bash
set -e

cd /data/src 
/usr/local/php-5.4.43/bin/pecl download redis-3.1.6
tar -zxvf redis-3.1.6.tgz
cd redis-3.1.6
/usr/local/php-5.4.43/bin/phpize
./configure \
  --with-php-config=/usr/local/php-5.4.43/bin/php-config
make 
make install
echo "extension=redis.so" >> /usr/local/php-5.4.43/lib/php.ini

cd /data/src 
rm -rf redis-3.1.6
