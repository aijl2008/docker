FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>


RUN apt update && apt install -y wget gcc && \
    apt install -y libxml2-dev libssl-dev libjpeg-dev libpng12-dev libmcrypt-devlibreadline-dev libtidy-dev libxslt-dev pkg-config && \
    wget http://cn.php.net/distributions/php-7.1.13.tar.gz && \
    tar -zxvf php-7.1.13.tar.gz  && \
    cd php-7.1.13 && \
    ./configure \
      --prefix=/usr/local/php-7.1.13 \
      --enable-fpm \
      --sysconfdir=/data/etc/php/php-7.1.13 \
      --with-fpm-user=nobody \
      --with-fpm-group=nobody \
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