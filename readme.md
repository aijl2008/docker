[TOC]

# Build


## Build centos 7

```
docker build \
    -t aijl2008/centos \
    centos
```

## Build centos 7 && nginx 1.12.2

```
docker build \
    -t aijl2008/centos-nginx \
    centos-nginx   
```

## Build centos 7 && php7

```
docker build \
    -t aijl2008/centos-php7 \
    centos-php7   
```

## Build centos 7 && nginx 1.12.2 && php 7.1.13

```
docker build \
    -t aijl2008/centos-nginx-php7 \
    centos-nginx-php7
```

## Build centos 7 && nginx 1.12.2 && php 7.1.13

```
docker build \
    -t aijl2008/centos-nginx-php7-php5 \
    centos-nginx-php7-php5    
```

## Biuld mysql 5.7

```
docker build \
  -t aijl2008/mysql \
  mysql
```

## Biuld redis 3.2
```
docker build \
  -t aijl2008/redis \
  redis
```

## Biuld mongo 3.6
```
docker build \
  -t aijl2008/mysql \
  mongo
```

# usage

## start ubuntu

```
docker run -d --name=ubuntu \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    aijl2008/ubuntu
```

## start ubuntu-nginx-php7

```
docker run -d --name=ubuntu-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot \
    aijl2008/ubuntu-nginx-php7
```

## start ubuntu-nginx-php7-php5

```
docker run -d --name=ubuntu-nginx-php7-php5 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot \
    aijl2008/ubuntu-nginx-php7-php5
```

## start centos

```
docker run -d --name=centos \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    aijl2008/centos
```

## start centos-nginx-php7

```
docker run -d --name=centos-nginx-php7 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot \
    aijl2008/centos-nginx-php7
```

## start centos-nginx-php7-php5

```
docker run -d --name=centos-nginx-php7-php5 \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    -v /data/container/my-container/webroot:/data/webroot \
    aijl2008/centos-nginx-php7-php5
```

## start mysql

```
docker run -d --name mysql \
    -e MYSQL_ROOT_PASSWORD=123456 \
    -p 127.0.0.1:3306:3306 \
    -v /data/container/my-container/mysql:/var/lib/mysql \
    aijl2008/mysql
```

The MySQL Server log is available through Docker’s container log:

```
docker logs mysql
```


## start redis

```
docker run -d --name redis \
    -p 127.0.0.1:6379:6379 \
    -v /data/container/my-container/redis:/data \
    aijl2008/redis redis-server --appendonly yes
```

## start mongo

```
docker run -d --name redis \
    -p 127.0.0.1:27017:27017 \
    -v /data/container/my-container/mongo:/data/db \
    aijl2008/mongo
```




# change to your ipaddress:
```
sed "s/127.0.0.1/your ipaddress/g" readme.md
```