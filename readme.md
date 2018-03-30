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
docker build \
    -t docker.artron.net:5000/centos \
    centos
docker build \
    -t docker.artron.net:5000/centos-nginx \
    centos-nginx   
docker build \
    -t docker.artron.net:5000/centos-nginx-php-7 \
    centos-nginx-php-7
docker build \
    -t docker.artron.net:5000/centos-nginx-php-5 \
    centos-nginx-php-5    
```

# run
```
docker run -d --name=ubuntu \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/ubuntu 
docker run -d --name=ubuntu-nginx \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/ubuntu-nginx 
docker run -d --name=ubuntu-nginx-php \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/ubuntu-nginx-php    
ssh root@127.0.0.1 -p 4501
```

```
docker run -d --name=centos \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    docker.artron.net:5000/centos 
docker run -d --name=centos-nginx \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/centos-nginx 
docker run -d --name=centos-nginx-php \
    -p 127.0.0.1:9999:9999 \
    -p 127.0.0.1:4501:22 \
    -p 127.0.0.1:80:80 \
    -p 127.0.0.1:443:443 \
    docker.artron.net:5000/centos-nginx-php    
ssh root@127.0.0.1 -p 4501
```
