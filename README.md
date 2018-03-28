# Docker NGINX-based image

## Description

Docker NGINX-based image. Use as image for database container. 
Was developed for using with [Docker Manager](https://github.com/demmonico/docker-manager/). 
But could be used separately.
You could pull image from here and build locally either pull from [Docker Hub](https://hub.docker.com/r/demmonico/ubuntu-mariadb/) directly.


### Installs

- Ubuntu 14.04
- NGINX
- curl, zip, unzip
- supervisor
- mc, rsync, htop, nano


### Build arguments

- DMB_CUSTOM_BUILD_COMMAND (will run if defined in the end of build)


### Environment variables

- DM_PROJECT_ENV
- DMC_INSTALL_DIR
- DMC_ROOT_PASSWD (on `run_once`)
- DMC_DM_USER  (on `run_once`)
- DMC_DM_PASSWD  (on `run_once`)
- DMC_CUSTOM_RUN_COMMAND
- DMC_CUSTOM_RUNONCE_COMMAND
- DMC_EXEC_NAME (pass container's name while `exec` cmd)
- DMC_NGINX_APPUPSTREAM (customize nginx upstream settings, allow multi-servers structure, load balance configure etc.)


## Build && push

### Build

Build image with default NGINX version
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
  
# optional copy files to install container
COPY install "${DMC_INSTALL_DIR}/"
  
CMD ["/run.sh"]
```

### Docker Compose

```sh
...
nginx:
  image: demmonico/ubuntu-nginx
  # or
  build: local_path_to_dockerfile
      
  environment:
    # optional to provide custom upstream config
    - DMC_NGINX_APPUPSTREAM=ip_hash; server app1:80 weight=1 max_fails=3; server app2:80;
    
  volumes:
    # optional to provide custom proxy config
    - ./proxy/nginx-conf/proxy.conf:/etc/nginx/conf.d/proxy.custom
...
```


## Change log

See the [CHANGELOG](CHANGELOG.md) file for change logs.
