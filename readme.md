[TOC]

# Build

## Build ubuntu 16.04

```
docker build \
    -t docker.artron.net:5000/ubuntu \
    ubuntu
```

## Build ubuntu 16.04 && nginx 1.12.2

```
docker build \
    -t docker.artron.net:5000/ubuntu-nginx \
    ubuntu-nginx   
```

## Build ubuntu 16.04 && nginx 1.12.2 && php 7.1.13

```
docker build \
    -t docker.artron.net:5000/ubuntu-nginx-php7 \
    ubuntu-nginx-php7
```

## Build ubuntu 16.04 && nginx 1.12.2  && php 7.1.13 && php 5.4.43

```
docker build \
    -t docker.artron.net:5000/ubuntu-nginx-php7-php5 \
    ubuntu-nginx-php7-php5 
```

## Build centos 7

```
docker build \
    -t docker.artron.net:5000/centos \
    centos
```

## Build centos 7 && nginx 1.12.2

```
docker build \
    -t docker.artron.net:5000/centos-nginx \
    centos-nginx   
```

## Build centos 7 && nginx 1.12.2 && php 7.1.13

```
docker build \
    -t docker.artron.net:5000/centos-nginx-php7 \
    centos-nginx-php7
```

## Build centos 7 && nginx 1.12.2 && php 7.1.13

```
docker build \
    -t docker.artron.net:5000/centos-nginx-php7-php5 \
    centos-nginx-php7-php5    
```

## Biuld mysql 5.7

```
docker build \
  -t docker.artron.net:5000/mysql \
  mysql
```

## Biuld redis 3.2
```
docker build \
  -t docker.artron.net:5000/redis \
  redis
```

## Biuld mongo 3.6
```
docker build \
  -t docker.artron.net:5000/mysql \
  mongo
```

# run

```
docker run -d --name=ubuntu \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/ubuntu 
docker run -d --name=ubuntu-nginx \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/ubuntu-nginx 
docker run -d --name=ubuntu-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/ubuntu-nginx-php7    
ssh root@127.0.0.1 -p 4501
```

```
docker run -d --name=centos \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/centos 
docker run -d --name=centos-nginx \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/centos-nginx 
docker run -d --name=centos-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/centos-nginx-php7    
ssh root@127.0.0.1 -p 4501
```

```
sudo docker rm redis --force
docker run \
    --name redis \
    -v /data/docker/redis/:/data \
    -d \
    artron/redis:3.2 redis-server --appendonly yes
```

change to your ipaddress:
```
sed "s/127.0.0.1/your ipaddress/g" readme.md
```
