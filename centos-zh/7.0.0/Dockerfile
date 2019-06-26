FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
