#!/bin/bash
set -e
yum install -y gcc automake autoconf libtool make gcc-c++
yum install -y net-tools wget httpd-tools \
yum install -y initscripts
yum install -y openssl-devel
yum install -y tree
yum install -y curl-devel
yum install -y freetype-devel
yum install -y readline-devel
yum install -y libtidy-devel
yum install -y libxml2-devel
yum install -y libicu-devel
yum install -y libxslt-devel
yum install -y libmcrypt-devel
yum install -y libpng-devel
yum install -y libssh2-devel
yum install -y kde-l10n-Chinese
yum reinstall -y glibc-common
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
