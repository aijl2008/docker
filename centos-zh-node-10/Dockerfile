FROM aijl2008/centos-zh:7.0.0
MAINTAINER Jerry Ai <awz@awz.cn>

RUN yum install -y wget
RUN wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz
RUN xz -d node-v10.16.0-linux-x64.tar.xz
RUN tar -xvf node-v10.16.0-linux-x64.tar
RUN ln -s /node-v10.16.0-linux-x64/bin/* /usr/local/bin/
RUN chmod +x node-v10.16.0-linux-x64/bin/*
RUN npm install pm2 -g --registry=https://registry.npm.taobao.org
