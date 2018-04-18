#!/bin/bash
set -e
echo "安装 supervisor 包"
yum install -y supervisor
echo "创建日志目录"
mkdir -p /data/logs/supervisor
echo "配置/etc/supervisord.conf"
echo_supervisord_conf | \
 sed "s/;\[inet_http_server\]/[inet_http_server]/" | \
 sed "s/;port=127.0.0.1:9001/port=0.0.0.0:9999/" | \
 sed "s/;\[include\]/[include]/" | \
 sed "s/\/tmp\/supervisord.log/\/data\/logs\/supervisor\/supervisord.log/" | \
 sed "s/;files = relative\/directory/files = \/etc\/supervisord.d/" \
 > /etc/supervisord.conf
