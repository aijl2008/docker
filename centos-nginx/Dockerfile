FROM docker.artron.net:5000/centos
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src

## Install nginx
RUN sh /data/src/install-nginx.sh

EXPOSE 80 443

