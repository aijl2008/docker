#!/bin/bash
apt install -y supervisor
mkdir -p /data/logs/supervisor
sed -i "s/\/var\/log/\/data\/logs/" /etc/supervisor/supervisord.conf
echo "[inet_http_server]" >> /etc/supervisor/supervisord.conf
echo "port=0.0.0.0:9999" >> /etc/supervisor/supervisord.conf
 