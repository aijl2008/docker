```
sudo docker build -t aijl2008/mysql .
```

```
sudo docker rm mysql --force
```

```
docker run \
    --name mysql \
    -v /data/docker/container/mysql/etc/:/etc/mysql/conf.d \
    -v /data/docker/container/mysql:/var/lib/mysql \
    -d \
    aijl2008/mysql mongo
```
