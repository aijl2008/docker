```
sudo docker build -t aijl2008/mongo .
```

```
sudo docker rm mongo --force
```

```
docker run \
    --name mongo \
    -v /data/docker/container/mongo:/data/db \
    -d \
    aijl2008/mongo
```