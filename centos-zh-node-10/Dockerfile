FROM aijl2008/centos-zh
MAINTAINER Jerry Ai <awz@awz.cn>

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

RUN wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz -O ~/node-v10.16.0-linux-x64.tar.xz
RUN tar -zxvf node-v10.16.0-linux-x64.tar.xz
RUN ln -s node-v10.16.0-linux-x64/bin/* /usr/local/bin/
RUN npm install pm2 -g --registry=https://registry.npm.taobao.org