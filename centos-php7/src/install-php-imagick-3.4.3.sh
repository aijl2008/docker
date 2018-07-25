#!/bin/bash
set -e
yum install -y ImageMagick-devel
cd /data/src 
/usr/local/php-7.1.13/bin/pecl download imagick-3.4.3
tar -zxvf imagick-3.4.3.tgz
cd imagick-3.4.3
/usr/local/php-7.1.13/bin/phpize
./configure \
  --with-php-config=/usr/local/php-7.1.13/bin/php-config
make 
make install
echo "extension=mongodb.so" >> /usr/local/php-7.1.13/lib/php.ini


cd /data/src 
rm -rf mongodb-1.4.2
