```
sudo docker build -t  aijl2008/centos-zh .
```

```
sudo docker rm centos-zh --force
```

```
docker run \
    --name centos-zh \
    -it \
    aijl2008/centos \
    /bin/bash