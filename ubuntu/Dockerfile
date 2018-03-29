FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

RUN set -e && \
    sed -i "s/archive.ubuntu.com/cn.archive.ubuntu.com/g" /etc/apt/sources.list && \
    apt update && \
    apt install -y vim wget tree curl && \
    apt install -y gcc autoconf pkg-config && \
    apt install -y libxml2-dev \
                   libpcre3-dev \
                   libssl-dev \
                   libcurl4-openssl-dev \
                   libjpeg-dev \
                   libpng12-dev \
                   libmcrypt-dev \
                   libreadline-dev \
                   libtidy-dev \
                   libxslt-dev && \
    
    apt install -y supervisor && \
    sed -i "s/\/var\/log/\/data\/logs/" /etc/supervisor/supervisord.conf  && \
    echo "[inet_http_server]" >> /etc/supervisor/supervisord.conf  && \ 
    echo "port=0.0.0.0:9999" >> /etc/supervisor/supervisord.conf  && \

    apt install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:centos' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # SSH login fix. Otherwise user is kicked off after login
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd  && \
    echo "export VISIBLE=now" >> /etc/profile && \

    apt install -y git subversion && \

    apt install -y language-pack-zh-hans locales tzdata && \
    update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

    rm -rf /var/lib/apt/lists/*

ENV LANG zh_CN.UTF-8
ENV NOTVISIBLE "in users profile"

RUN { \
    echo '[program:sshd]'; \
    echo 'command=/usr/sbin/sshd -D'; \
} > /etc/supervisor/conf.d/sshd.ini

EXPOSE 9999 22

ADD entrypoint.sh entrypoint.sh
WORKDIR /data/logs/supervisor/
CMD ["supervisord","-n","-c","/etc/supervisor/supervisord.conf"]


