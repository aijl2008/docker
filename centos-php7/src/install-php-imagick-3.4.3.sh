#!/bin/bash
set -e
yum install GraphicsMagick-dev
cd /data/src 
/usr/local/php-7.1.13/bin/pecl download gmagick-2.0.5RC1
tar -zxvf gmagick-2.0.5RC1.tgz
cd gmagick-2.0.5RC1
/usr/local/php-7.1.13/bin/phpize
./configure \
  --with-php-config=/usr/local/php-7.1.13/bin/php-config
make 
make install
echo "extension=gmagick.so" >> /usr/local/php-7.1.13/lib/php.ini


cd /data/src 
rm -rf gmagick-2.0.5RC1
