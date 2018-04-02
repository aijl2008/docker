#!/bin/bash
set -e
apt install -y vim wget tree curl
apt install -y gcc autoconf pkg-config net-tools
apt install -y libxml2-dev \
               libpcre3-dev \
               libssl-dev \
               libcurl4-openssl-dev \
               libjpeg-dev \
               libpng12-dev \
               libmcrypt-dev \
               libreadline-dev \
               libtidy-dev \
               libxslt-dev
apt install -y language-pack-zh-hans locales tzdata
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 
