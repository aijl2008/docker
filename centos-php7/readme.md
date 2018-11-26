```
sudo docker build -t  aijl2008/centos-php7 .
```

```
sudo docker rm centos-php7 --force
```

```
docker run \
    --name centos-php7 \
    -v /data/docker/container/centos-php7:/data/webroot \
    -p 0.0.0.0:9999:9999 \
    -p 0.0.0.0:4501:22 \
    -d \
    aijl2008/centos-php7
```


