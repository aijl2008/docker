```
sudo docker build -t  aijl2008/centos-zh-node .
```

```
sudo docker rm centos-zh-node --force
```

```
docker run \
    --name centos-zh-node \
    -it \
    aijl2008/centos-zh-node \
    /bin/bash