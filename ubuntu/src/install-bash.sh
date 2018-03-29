#!/bin/bash
set -e
apt install -y vim wget tree curl
apt install -y gcc autoconf pkg-config
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