#!/bin/bash
set -e
yum install -y openssh openssh-clients openssh-server
/usr/sbin/sshd-keygen -A
echo 'root:centos' |chpasswd
