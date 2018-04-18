#!/bin/bash
set -e
groupadd -f -g 501 www-data
useradd -m -u 501 -g 501 www-data
mkdir -p /data/webroot && chown www-data:www-data /data/webroot
mkdir -p /data/logs/nginx
su www-data -c "echo '<?php phpinfo();?>' > /data/webroot/phpinfo.php"

mkdir -p /data/src
cd /data/src && wget -nv http://nginx.org/download/nginx-1.12.2.tar.gz
tar -zxvf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure \
    --prefix=/usr/local/nginx-1.12.2 \
    --error-log-path=/data/logs/nginx/error.log \
    --http-log-path=/data/logs/nginx/access.log \
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
    --with-stream_ssl_preread_module
make && make install
mkdir -p /usr/local/nginx-1.12.2/conf/vhost
mkdir -p /data/logs/nginx


echo 'user www-data;
worker_processes  2;
error_log /data/logs/nginx/error.log;
pid /data/logs/nginx/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include mime.types;
    client_max_body_size 20m;
    server_names_hash_bucket_size 512;
    default_type  application/octet-stream;
    log_format  main  $host $remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for";
    access_log  /data/logs/nginx/access.log  main;
    sendfile        on;
    keepalive_timeout  65;
    gzip  on;
    include vhost/*.conf;
}' > /usr/local/nginx-1.12.2/conf/nginx.conf

echo 'server {
    listen 80;
    server_name localhost;
    listen 443 ssl;
    ssl_certificate ssl/cert.pem;
    ssl_certificate_key ssl/cert.key;
    charset utf-8;
    access_log  /data/logs/nginx/default.access.log  main;
    error_log  /data/logs/nginx/default.error.log;
    root /data/webroot;
    autoindex on;
    location / {
            index index.html index.php;
            try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:7113;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}'  > /usr/local/nginx-1.12.2/conf/vhost/default.conf

echo '[program:nginx]
command=/usr/local/nginx-1.12.2/sbin/nginx -g "daemon off;" -c /usr/local/nginx-1.12.2/conf/nginx.conf
' > /etc/supervisord.d/nginx.ini
cd /
rm -rf /data/src/nginx-1.12.2
