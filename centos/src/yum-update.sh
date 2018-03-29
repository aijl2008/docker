#!/bin/bash
set -e
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
rpm -ivh https://www.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/atomic-release-1.0-21.el7.art.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum clean all && yum makecache