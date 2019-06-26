```
sudo docker build -t  aijl2008/centos-zh-node:10.16.0 .
```

```
sudo docker rm centos-zh-node --force
```

```
sudo docker run \
    --name centos-zh-node \
    -it \
    aijl2008/centos-zh-node:10.16.0 \
    /bin/bash
