FROM docker.artron.net:5000/ubuntu
MAINTAINER Jerry Ai <awz@awz.cn>

RUN set -e && \
    # create user and group
    /usr/sbin/userdel www-data && \
    /usr/sbin/groupadd -g 501 www-data && \
    /usr/sbin/groupadd -g 510 php-fpm && \
    /usr/sbin/useradd -d /data/webroot -u 501 -g 501 www-data && \
    /usr/sbin/useradd -d /data/webroot/runtimes -u 510 -g 510 php-fpm && \
    su www-data -c "echo '<?php phpinfo();?>' > /data/webroot/phpinfo.php" && \

    # download
    mkdir -p /data/src && \
    cd /data/src && wget http://nginx.org/download/nginx-1.12.2.tar.gz && \
    tar -zxvf nginx-1.12.2.tar.gz && \
    cd nginx-1.12.2 && \
    # install
    ./configure \
        --prefix=/usr/local/nginx-1.12.2 \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --user=www-data \
        --group=www-data \
        --with-compat \
        --with-file-aio \
        --with-threads \
        --with-http_addition_module \
        --with-http_auth_request_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_mp4_module \
        --with-http_random_index_module \
        --with-http_realip_module \
        --with-http_secure_link_module \
        --with-http_slice_module \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_sub_module \
        --with-http_v2_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-stream \
        --with-stream_realip_module \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module && \
    make && make install && \
    mkdir -p /usr/local/nginx-1.12.2/conf/vhost
# create ssl ca
COPY ssl/cert.key /usr/local/nginx-1.12.2/conf/cert.key
COPY ssl/cert.pem /usr/local/nginx-1.12.2/conf/cert.pem
# create nginx.conf
RUN { \
    echo 'user www-data;'; \
    echo 'worker_processes  1;'; \
    echo 'error_log /data/logs/error.log;'; \
    echo 'pid logs/nginx.pid;'; \
    echo 'events {'; \
    echo '    worker_connections  1024;'; \
    echo '}'; \
    echo 'http {'; \
    echo '    include mime.types;'; \
    echo '    default_type  application/octet-stream;'; \
    echo '    log_format  main  $host $remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for";'; \
    echo '    access_log  /data/logs/access.log  main;'; \
    echo '    sendfile        on;'; \
    echo '    keepalive_timeout  65;'; \
    echo '    gzip  on;'; \
    echo '    include vhost/*.conf;'; \
    echo '}'; \
} > /usr/local/nginx-1.12.2/conf/nginx.conf
# create vhost/default.conf
RUN { \
    echo 'server {'; \
    echo '    listen 80;'; \
    echo '    server_name localhost;'; \
    echo '    listen 443 ssl;'; \
    echo '    ssl_certificate cert.pem;'; \
    echo '    ssl_certificate_key cert.key;'; \
    echo '    charset utf-8;'; \
    echo '    access_log  logs/default.access.log  main;'; \
    echo '    error_log  logs/default.error.log;'; \
    echo '    root /data/webroot;'; \
    echo '    autoindex on;'; \
    echo '    location / {'; \
    echo '            index index.html index.php;'; \
    echo '            try_files $uri $uri/ /index.php?$args;'; \
    echo '    }'; \
    echo '    location ~ \.php$ {'; \
    echo '        fastcgi_pass 127.0.0.1:7113;'; \
    echo '        fastcgi_index index.php;'; \
    echo '        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;'; \
    echo '        include fastcgi_params;'; \
    echo '    }'; \
    echo '}'; \
} > /usr/local/nginx-1.12.2/conf/vhost/default.conf

VOLUME ["/data/webroot", "/data/webroot/runtimes", "/data/log"]

RUN { \
    echo '[program:nginx]'; \
    echo 'command=/usr/local/nginx-1.12.2/sbin/nginx';
} > /etc/supervisord.d/nginx.ini

EXPOSE [80, 443]

