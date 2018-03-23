# Dockerfile for build app container
#
# tech-stack: ubuntu / nginx
#
# @author demmonico
# @image ubuntu-nginx
# @version v3.2


FROM ubuntu:14.04
MAINTAINER demmonico@gmail.com


### ENV CONFIG
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# for mc
ENV TERM xterm

# additional files required to run container
ENV DMC_INSTALL_DIR="/dm-install"



### INSTALL SOFTWARE
RUN apt-get -yqq update \
    && apt-get -yqq install software-properties-common \
    && apt-get -yqq update \

    # nginx, curl, zip, unzip
    && apt-get install -yqq --force-yes  --no-install-recommends nginx curl zip unzip \

    # demonisation for docker
    && apt-get -yqq install supervisor && mkdir -p /var/log/supervisor \

    # mc, rsync and other utils
    && apt-get -yqq install mc rsync htop nano



### UPDATE & RUN PROJECT

EXPOSE 80

# copy supervisord config file
COPY supervisord.conf /etc/supervisor/supervisord.conf

# copy nginx config's template file
COPY proxy.template /etc/nginx/conf.d/proxy.template

# copy and init run_once script
COPY run_once.sh /run_once.sh
ENV DMC_RUN_ONCE_FLAG "/run_once_flag"
RUN tee "${DMC_RUN_ONCE_FLAG}" && chmod +x /run_once.sh

# run custom run command if defined
ARG DMB_CUSTOM_BUILD_COMMAND
RUN ${DMB_CUSTOM_BUILD_COMMAND:-":"}



# clean temporary and unused folders and caches
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



# copy and init run script
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
