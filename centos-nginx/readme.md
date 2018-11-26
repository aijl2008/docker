```
sudo docker build -t  aijl2008/centos-nginx .
```

```
sudo docker rm centos-nginx --force
```

```
docker run \
    --name centos-nginx \
    -v /data/docker/container/centos-nginx:/data/webroot \
    -p 0.0.0.0:9999:9999 \
    -p 0.0.0.0:4501:22 \
    -p 0.0.0.0:80:80 \
    -p 0.0.0.0:443:443 \
    -d \
    aijl2008/centos-nginx