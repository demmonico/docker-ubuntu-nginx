# Docker NGINX-based image

## Description

Docker NGINX-based image. Use as image for proxy container.


### Installs

- Ubuntu 14.04
- NGINX 1.4.6
- curl, zip, unzip
- supervisor
- mc, rsync, htop


### Build arguments

- CUSTOM_BUILD_COMMAND (will run if defined in the end of build)


### Environment variables

- INSTALL_DIR
- APP_UPSTREAM (customize nginx upstream settings, allow multi-servers structure, load balance configure etc.)


## Build && push

### Build

```sh
docker build -t demmonico/ubuntu-nginx --no-cache .
```

### Make tag

```sh
docker tag IMAGE_ID demmonico/ubuntu-nginx:1.4.6
```

### Push image to Docker Hub

```sh
docker push demmonico/ubuntu-nginx
```
or with tag
```sh
docker push demmonico/ubuntu-nginx:1.4.6
```


## Usage

### Dockerfile

```sh
FROM demmonico/ubuntu-nginx

VIRTUAL_HOST=example.com

# optional
ENV APP_UPSTREAM=server app:80;

CMD ["/run.sh"]
```

### Docker Compose

```sh
...
image: demmonico/ubuntu-nginx

# optional to provide custom upstream config
environment:
  - APP_UPSTREAM=ip_hash; server app1:80 weight=1 max_fails=3; server app2:80;

# optional to provide custom proxy config
volumes:
  - ./proxy/nginx-conf/proxy.conf:/etc/nginx/conf.d/proxy.custom
```


## Change log

See the [CHANGELOG](CHANGELOG.md) file for change logs.
