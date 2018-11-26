```
sudo docker build -t aijl2008/redis .
```

```
sudo docker rm redis --force
```

```
sudo docker run \
    --name redis \
    -v /data/docker/redis/:/data \
    -d \
    aijl2008/redis redis_server --appendonly yes
```