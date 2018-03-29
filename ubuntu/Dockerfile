FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

COPY src /data/src
## Update APT Repo
RUN sh /data/src/apt-update.sh
## Install Base apt
RUN sh /data/src/install-base.sh
## Install Supervisor
RUN sh /data/src/install-supervisor.sh
## Install Sshd
RUN sh /data/src/install-sshd.sh
## Install VCS
RUN sh /data/src/install-vcs.sh

EXPOSE 22 9999
 
CMD ["supervisord","-n","-c","/etc/supervisor/supervisord.conf"]
