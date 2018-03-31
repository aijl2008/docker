#!/bin/bash
set -e

apt install -y libssh2-1-dev 
cd /data/src
/usr/local/php-7.1.13/bin/pecl download ssh2-1.1.2
tar -zxvf ssh2-1.1.2.tgz
cd ssh2-1.1.2
/usr/local/php-7.1.13/bin/phpize
./configure \
  --with-php-config=/usr/local/php-7.1.13/bin/php-config
make 
make install
echo "extension=ssh2.so" >> /usr/local/php-7.1.13/lib/php.ini
