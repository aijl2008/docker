FROM docker.artron.net:5000/ubuntu-nginx-php7

COPY src /data/src
RUN sh /data/src/install-php-5.4.43.sh
RUN sh /data/src/install-php-redis-3.1.6.sh
RUN sh /data/src/install-php-mongodb-1.2.11.sh
RUN sh /data/src/install-php-composer.sh
