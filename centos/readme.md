```
sudo docker build -t  aijl2008/centos .
```

```
sudo docker rm centos --force
```

```
docker run \
    --name centos \
    -p 0.0.0.0:9999:9999 \
    -p 0.0.0.0:4501:22 \
    -d \
    aijl2008/centos