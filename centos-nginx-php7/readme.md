```
sudo docker build -t  aijl2008/centos-nginx-php7 .
```

```
sudo docker rm centos-nginx-php7 --force
```

```
docker run \
    --name centos-nginx-php7 \
    -v /data/docker/container/centos-nginx-php7:/data/webroot \
    -p 0.0.0.0:9999:9999 \
    -p 0.0.0.0:4501:22 \
    -p 0.0.0.0:80:80 \
    -p 0.0.0.0:443:443 \
    -d \
    aijl2008/centos-nginx-php7