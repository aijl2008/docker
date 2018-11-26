FROM mongo:3.7

ENV TZ=Asia/Shanghai
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g"  /etc/apt/sources.list
RUN apt update
RUN apt install -y locales locales-all tzdata net-tools wget curl vim
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone