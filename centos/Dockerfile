FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src

RUN sh /data/src/update.sh
RUN sh /data/src/install-base.sh
RUN sh /data/src/install-supervisor.sh
RUN sh /data/src/install-sshd.sh
RUN sh /data/src/install-vcs.sh

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

EXPOSE 22 9999
CMD ["supervisord","-n","-c","/etc/supervisord.conf"]
