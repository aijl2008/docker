FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

RUN apt update && apt install -y wget gcc && \
    wget http://nginx.org/download/nginx-1.12.2.tar.gz && \
    tar -zxvf nginx-1.12.2.tar.gz && \
    mkdir -p /data/etc/nginx && mkdir -p /data/log/nginx && mkdir /data/webroot && \
    cd nginx-1.12.2 && \
    ./configure \
        --prefix=/usr/local/nginx-1.12.2 \
        --conf-path=/data/etc/nginx \
        --error-log-path=/data/log/nginx/error.log \
        --http-log-path=/data/log/nginx/access.log \
        --user=nginx \
        --group=nginx \
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
    sed "s/#user  nobody;/user  nobody;/" /data/etc/nginx/nginx.conf

#COPY etc/nginx/ssl/cert.pem /data/etc/nginx/ssl/cert.pem
#COPY etc/nginx/ssl/cert.pem /data/etc/nginx/ssl/cert.pem

CMD ["/usr/local/nginx-1.12.2/sbin/nginx","-c","/data/etc/nginx/nginx.conf"]