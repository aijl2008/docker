FROM aijl2008/centos
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src

RUN sh /data/src/install-php-7.1.13.sh
RUN sh /data/src/install-php-redis-3.1.6.sh
RUN sh /data/src/install-php-mongodb-1.4.2.sh
RUN sh /data/src/install-php-imagick-2.0.5RC1.sh
RUN sh /data/src/install-php-composer.sh
RUN sh /data/src/install-php-ssh2-1.1.2.sh