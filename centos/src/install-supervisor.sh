#!/bin/bash
set -e
yum install -y supervisor
mkdir -p /etc/supervisor/supervisord.d
mkdir -p /data/logs/supervisor
echo_supervisord_conf | \
 sed "s/;\[inet_http_server\]/[inet_http_server]/" | \
 sed "s/;port=127.0.0.1:9001/port=0.0.0.0:9999/" | \
 sed "s/;\[include\]/[include]/" | \
 sed "s/\/tmp\/supervisord.log/\/data\/logs\/supervisor\/supervisord.log/" | \
 sed "s/;files = relative\/directory/files = \/etc\/supervisor\/supervisord.d/" \
 > /etc/supervisor/supervisord.conf
