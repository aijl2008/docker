#!/bin/bash
set -e
yum install -y openssh openssh-clients openssh-server
/usr/sbin/sshd-keygen -A
echo 'root:centos' |chpasswd

echo '
[program:sshd]
command=/usr/sbin/sshd -D
' > /etc/supervisor/supervisor.d/sshd.ini
 
