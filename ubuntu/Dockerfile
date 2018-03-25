FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

RUN set -e && \
    sed -i "s/archive.ubuntu.com/cn.archive.ubuntu.com/g" /etc/apt/sources.list && \
    apt update && \
    apt install -y vim wget  && \
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
    # install supervisor
    mkdir -p /data/logs/supervisor && \
    mkdir -p /etc/supervisord.d && \
    apt install -y supervisor && \
    echo_supervisord_conf | \
        sed "s/;\[inet_http_server\]/[inet_http_server]/" | \
        sed "s/;port=127.0.0.1:9001/port=0.0.0.0:9999/" | \
        sed "s/;\[include\]/[include]/" | \
        sed "s/\/tmp\/supervisord.log/\/data\/logs\/supervisor\/supervisord.log/" | \
        sed "s/;files = relative\/directory/files = \/etc\/supervisord.d/" \
        > /etc/supervisord.conf && \

    # install sshd
    apt install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:centos' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # SSH login fix. Otherwise user is kicked off after login
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd  && \
    echo "export VISIBLE=now" >> /etc/profile && \

    # install vcs
    apt install -y git subversion && \

    # install locale
    apt install -y language-pack-zh-hans locales tzdata && \
    update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

    # clear apt cache
    rm -rf /var/lib/apt/lists/*

ENV LANG zh_CN.UTF-8
ENV NOTVISIBLE "in users profile"

RUN { \
    echo '[program:sshd]'; \
    echo 'command=/usr/sbin/sshd -D'; \
} > /etc/supervisord.d/sshd.ini

EXPOSE 9999 22

CMD ["supervisord","-n","-c","/etc/supervisord.conf"]


