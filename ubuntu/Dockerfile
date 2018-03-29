FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src

RUN sh /data/src/update.sh
RUN sh /data/src/install-base.sh
RUN sh /data/src/install-supervisor.sh
RUN sh /data/src/install-sshd.sh
RUN sh /data/src/install-vcs.sh

EXPOSE 22 9999
 
CMD ["supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
