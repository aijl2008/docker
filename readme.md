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

# usage

## start ubuntu

```
docker run -d --name=ubuntu \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/ubuntu 
```

## start ubuntu-nginx-php7

```
docker run -d --name=ubuntu-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot
    docker.artron.net:5000/ubuntu-nginx-php7
```

## start ubuntu-nginx-php7-php5

```
docker run -d --name=ubuntu-nginx-php7-php5 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot
    docker.artron.net:5000/ubuntu-nginx-php7-php5
```


## start centos

```
docker run -d --name=centos \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/centos
```

## start centos-nginx-php7

```
docker run -d --name=centos-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot
    docker.artron.net:5000/centos-nginx-php7
```

## start centos-nginx-php7-php5

```
docker run -d --name=centos-nginx-php7-php5 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot
    docker.artron.net:5000/centos-nginx-php7-php5
```

## start mysql

```
docker run -d --name mysql \
    -p 127.0.0.1:3306:3306
    -v /data/container/my-container/mysql/:/var/lib/mysql \
    docker.artron.net:5000/mysql
```

## start redis

```
docker run -d --name redis \
    -p 127.0.0.1:6379:6379
    -v /data/container/my-container/redis/:/data \
    docker.artron.net:5000/redis redis-server --appendonly yes
```

## start mongo

```
docker run -d --name redis \
    -p 127.0.0.1:27017:27017
    -v /data/container/my-container/mongo/:/data \
    docker.artron.net:5000/mongo
```




# change to your ipaddress:
```
sed "s/127.0.0.1/your ipaddress/g" readme.md
```
