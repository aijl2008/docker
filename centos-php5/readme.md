```
sudo docker build -t  aijl2008/centos-php5 .
```

```
sudo docker rm centos-php5 --force
```

```
docker run \
    --name centos-php5 \
    -v /data/docker/container/centos-php5:/data/webroot \
    -p 0.0.0.0:9999:9999 \
    -p 0.0.0.0:4501:22 \
    -d \
    aijl2008/centos-php5