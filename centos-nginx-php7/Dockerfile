FROM aijl2008/centos-php7
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src
RUN sh /data/src/install-nginx.sh

ADD conf /usr/local/nginx-1.12.2/conf

EXPOSE 80 443

