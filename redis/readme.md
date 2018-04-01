```
sudo docker build -t artron/redis:3.2 .
```

```
sudo docker rm redis --force
docker run \
    --name redis \
    -v /data/docker/redis/:/data \
    -d \
    artron/redis:3.2 redis-server --appendonly yes
```