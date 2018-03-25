FROM ubuntu:16.04
MAINTAINER Jerry Ai <awz@awz.cn>

RUN sed -i "s/archive.ubuntu.com/cn.archive.ubuntu.com/g" /etc/apt/sources.list && \
    apt update && \
    apt install -y vim wget gcc && \
    apt install -y language-pack-zh-hans locales tzdata && \
    update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    rm -rf /var/lib/apt/lists/*
ENV LANG zh_CN.UTF-8
