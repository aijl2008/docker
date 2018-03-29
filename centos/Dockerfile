FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src

## Update Yum Repo
RUN sh /data/src/yum-update.sh

## Install Base RPM
RUN sh /data/src/install-base.sh

## Install Supervisor
RUN sh /data/src/install-supervisor.sh

## Install Sshd
RUN sh /data/src/install-sshd.sh

## Install VCS
RUN sh /data/src/install-vcs.sh


EXPOSE 22 9999

CMD ["supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
