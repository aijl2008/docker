FROM docker.artron.net:5000/ubuntu-nginx
MAINTAINER Jerry Ai <awz@awz.cn>

RUN set -e && \
    # download
    cd /data/src && wget http://cn.php.net/distributions/php-5.4.43.tar.gz && \
    tar -zxvf php-5.4.43.tar.gz  && \
    cd php-5.4.43 && \
    # install
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
      --enable-intl  \
      --enable-mbstring \
      --with-mcrypt \
      --with-mysqli \
      --enable-pcntl \
      --with-pdo-mysql \
      --with-readline \
      --enable-shmop  \
      --enable-soap  \
      --enable-sockets \
      --enable-sysvmsg \
      --enable-sysvsem \
      --enable-sysvshm \
      --with-tidy \
      --with-xmlrpc \
      --with-xsl=DIR \
      --enable-zip \
      --enable-mysqlnd && \
    make && make install && \

    # setting php.ini
    cp php.ini-production /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/display_errors = Off/display_errors = On/" /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/short_open_tag = Off/short_open_tag = On/" /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/;date.timezone =/date.timezone =Asia\/Shanghai/" /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/" /usr/local/php-5.4.43/lib/php.ini && \
    sed -i "s/;error_log = php_errors.log/error_log = \/data\/logs\/php\/php-5.4.43\/php_errors.log/" /usr/local/php-5.4.43/lib/php.ini && \

    mkdir -p /usr/local/php-5.4.43/etc/ && \
    mkdir -p /usr/local/php-5.4.43/etc/php-fpm.d && \

    # install mongo
    cd /data/src && /usr/local/php-5.4.43/bin/pecl download mongodb-1.2.11 && \
    tar -zxvf mongodb-1.2.11.tgz && \
    cd mongodb-1.2.11 && \
    /usr/local/php-5.4.43/bin/phpize && \
    ./configure --with-php-config=/usr/local/php-5.4.43/bin/php-config && \
    make && \ make install && \
    echo "extension=mongodb.so" >> /data/etc/php/php-5.4.43/lib/php.ini && \

    # install redis
    cd /data/src && /usr/local/php-5.4.43/bin/pecl download redis-3.1.6 && \
    tar -zxvf redis-3.1.6.tgz && \
    cd redis-3.1.6 && \
    /usr/local/php-5.4.43/bin/phpize && \
    ./configure --with-php-config=/usr/local/php-5.4.43/bin/php-config && \
    make && make install && \
    echo "extension=redis.so" >> /usr/local/php-5.4.43/lib/php.ini && \

# create php-fpm.conf
RUN { \
    echo '[global]'; \
    echo 'error_log = /data/logs/php/php-5.4.43/fpm_errors.log'; \
    echo 'process.max = 5'; \
    echo 'daemonize = no'; \
    echo 'include=php-fpm.d/*.conf'; \
} > /usr/local/php-5.4.43/etc/php-fpm.conf

# create pool-1 && pool-2
RUN { \
    echo '[pool-1]'; \
    echo 'user = php-fpm'; \
    echo 'group = php-fpm'; \
    echo 'listen = 127.0.0.1:7113'; \
    echo 'pm = static'; \
    echo 'pm.max_children = 5'; \
    echo 'pm.start_servers = 2'; \
    echo 'pm.min_spare_servers = 1'; \
    echo 'pm.max_spare_servers = 3'; \
    echo 'access.log = /data/logs/php/php-5.4.43/$pool.access.log'; \
    echo 'slowlog = /data/logs/php/php-5.4.43/$pool.log.slow'; \
    echo 'request_slowlog_timeout = 1'; \
} > /usr/local/php-5.4.43/etc/php-fpm.d/pool-1.conf
RUN { \
    echo '[pool-2]'; \
    echo 'user = php-fpm'; \
    echo 'group = php-fpm'; \
    echo 'listen = 127.0.0.1:7114'; \
    echo 'pm = static'; \
    echo 'pm.max_children = 5'; \
    echo 'pm.start_servers = 2'; \
    echo 'pm.min_spare_servers = 1'; \
    echo 'pm.max_spare_servers = 3'; \
    echo 'access.log = /data/logs/php/php-5.4.43/$pool.access.log'; \
    echo 'slowlog = /data/logs/php/php-5.4.43/$pool.log.slow'; \
    echo 'request_slowlog_timeout = 1'; \
} > /usr/local/php-5.4.43/etc/php-fpm.d/pool-2.conf

RUN { \
    echo '[program:fpm-7]'; \
    echo 'command=/usr/local/php-5.4.43/sbin/php-fpm -F';
} > /etc/supervisor/conf.d/fpm-7.ini
