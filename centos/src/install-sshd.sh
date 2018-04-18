#!/bin/bash
set -e

packages=(openssh \
openssh-clients \
openssh-server \
)
for var in ${packages[@]};
do
    echo "安装 $var 包"
    yum install -y $var
done
echo "生成私钥和公钥"
/usr/sbin/sshd-keygen -A
echo "修改root密码"
echo 'root:centos' |chpasswd

echo "配置supervisord"
echo '
[program:sshd]
command=/usr/sbin/sshd -D
' > /etc/supervisord.d/sshd.ini 
