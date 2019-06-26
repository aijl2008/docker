```
sudo docker build -t  aijl2008/centos-zh:7.0.0 .
```

```
sudo docker rm centos-zh --force
```

```
sudo docker run \
    --name centos-zh \
    -it \
    aijl2008/centos-zh:7.0.0 \
    /bin/bash
