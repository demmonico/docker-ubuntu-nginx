# Docker NGINX-based image

## Description

Docker NGINX-based image. Use as image for proxy container.
Was developed for using with [Docker Manager](https://github.com/demmonico/docker-manager/). 
But could be used separately.
You could pull image from here and build locally either pull from [Docker Hub](https://hub.docker.com/r/demmonico/ubuntu-nginx/) directly.


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

### Push image to Docker Hub

```sh
docker push demmonico/ubuntu-nginx
```


## Usage

### Dockerfile

```sh
FROM demmonico/ubuntu-nginx

# optional
ENV APP_UPSTREAM=server app:80;
  
CMD ["/run.sh"]
```

### Docker Compose

```sh
...
image: demmonico/ubuntu-nginx
# or
build: local_path_to_dockerfile
  
environment:
  # optional to provide custom upstream config
  - APP_UPSTREAM=ip_hash; server app1:80 weight=1 max_fails=3; server app2:80;
  
volumes:
  # optional to provide custom proxy config
  - ./proxy/nginx-conf/proxy.conf:/etc/nginx/conf.d/proxy.custom
  
env_file:
  # provides values for ENV variables VIRTUAL_HOST, PROJECT, HOST_USER_NAME, HOST_USER_ID
  - host.env
```


## Change log

See the [CHANGELOG](CHANGELOG.md) file for change logs.
