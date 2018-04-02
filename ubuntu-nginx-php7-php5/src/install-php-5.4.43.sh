#!/bin/bash
set -e

mkdir -p /data/src
cd /data/src
wget http://cn.php.net/distributions/php-5.4.43.tar.gz
tar -zxvf php-5.4.43.tar.gz
cd php-5.4.43

./configure \
  --prefix=/usr/local/php-5.4.43 \
  --enable-fpm \
  --with-fpm-user=php-fpm \
  --with-fpm-group=php-fpm \
  --enable-sigchild \
  --disable-short-tags \
  --with-libxml-dir \
  --with-openssl \
  --with-pcre-regex \
  --with-zlib \
  --enable-calendar \
  --with-curl \
  --enable-exif \
  --with-gd \
  --enable-gd-native-ttf \
  --with-gettext \
  --with-mhash \
  --enable-intl\
  --enable-mbstring \
  --with-mcrypt \
  --with-mysql \
  --with-mysqli \
  --enable-pcntl \
  --with-pdo-mysql \
  --with-readline \
  --enable-shmop\
  --enable-soap\
  --enable-sockets \
  --enable-sysvmsg \
  --enable-sysvsem \
  --enable-sysvshm \
  --with-tidy \
  --with-xmlrpc \
  --with-xsl=DIR \
  --enable-zip \
  --enable-mysqlnd
make
make install

cp php.ini-production /usr/local/php-5.4.43/lib/php.ini
sed -i "s/display_errors = Off/display_errors = On/" /usr/local/php-5.4.43/lib/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /usr/local/php-5.4.43/lib/php.ini
sed -i "s/short_open_tag = Off/short_open_tag = On/" /usr/local/php-5.4.43/lib/php.ini
sed -i "s/;date.timezone =/date.timezone =Asia\/Shanghai/" /usr/local/php-5.4.43/lib/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/" /usr/local/php-5.4.43/lib/php.ini
sed -i "s/;error_log = php_errors.log/error_log = \/data\/logs\/php\/php-5.4.43\/php_errors.log/" /usr/local/php-5.4.43/lib/php.ini

mkdir -p /data/logs/php/php-5.4.43

echo '
[global]
error_log = /data/logs/php/php-5.4.43/fpm_errors.log
process.max = 5
daemonize = no
include=etc/php-fpm.d/*.conf
' > /usr/local/php-5.4.43/etc/php-fpm.conf

mkdir /usr/local/php-5.4.43/etc/php-fpm.d

echo '[pool-1]
user = php-fpm
group = php-fpm
listen = 127.0.0.1:5443
pm = static
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
access.log = /data/logs/php/php-5.4.43/$pool.access.log
slowlog = /data/logs/php/php-5.4.43/$pool.log.slow
request_slowlog_timeout = 1
' > /usr/local/php-5.4.43/etc/php-fpm.d/pool-1.conf

echo '[pool-2]
user = php-fpm
group = php-fpm
listen = 127.0.0.1:5444
pm = static
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
access.log = /data/logs/php/php-5.4.43/$pool.access.log
slowlog = /data/logs/php/php-5.4.43/$pool.log.slow
request_slowlog_timeout = 1
' > /usr/local/php-5.4.43/etc/php-fpm.d/pool-2.conf

echo '[program:fpm-5]
command=/usr/local/php-5.4.43/sbin/php-fpm -F -y /usr/local/php-5.4.43/etc/php-fpm.conf
' > /etc/supervisor/conf.d/fpm-5.conf
