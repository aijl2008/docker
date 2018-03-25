# Build
```
docker build \
    -t docker.artron.net:5000/ubuntu \
    ubuntu
docker build \
    -t docker.artron.net:5000/ubuntu-nginx \
    ubuntu-nginx   
docker build \
    -t docker.artron.net:5000/ubuntu-nginx-php-7 \
    ubuntu-nginx-php-7
docker build \
    -t docker.artron.net:5000/ubuntu-nginx-php-5 \
    ubuntu-nginx-php-5          
```

# run
```
docker run -it docker.artron.net:5000/ubuntu /bin/bash
mkdir -p /data/container/default/logs
docker run -d --name=ubuntu \
    -v /data/container/default/logs:/data/logs \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/ubuntu 
docker inspect ubuntu
docker logs ubuntu
docker exec -it ubuntu
ssh root@127.0.0.1 -p 4501
```

```
mkdir -p /data/container/default/logs
docker run -d --name=nginx \
    -v /data/container/default/logs:/data/logs \
    -v /data/container/default/webroot:/data/webroot \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:443:443 \
    -p 127.0.0.1:80:80 \
    docker.artron.net:5000/ubuntu 
docker inspect nginx
docker exec -it nginx
ssh root@127.0.0.1 -p 4501
```