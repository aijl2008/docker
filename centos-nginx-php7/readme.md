```
sudo docker build -t aijl2008/centos-nginx-php7 .
```

### 删除已存在
```
sudo docker rm redis --force
```
### 启动
```
docker run \
    --name redis \
    -v /data/docker/redis/:/data \
    -d \
    artron/redis:3.2 redis-server --appendonly yes
```