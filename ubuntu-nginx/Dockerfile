FROM docker.artron.net:5000/ubuntu
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src
RUN sh /data/src/install-nginx.sh
COPY ../ssl /usr/local/nginx-1.12.2/conf

EXPOSE 80 443
