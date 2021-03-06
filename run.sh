#!/usr/bin/env bash
#
# This file has executed each time when container's starts
#
# tech-stack: ubuntu / nginx
#
# @author demmonico
# @image ubuntu-nginx
# @version v3.3



##### run once
if [ -f "${DMC_RUN_ONCE_FLAG}" ]; then
  # run script once
  source /run_once.sh
  # rm flag
  /bin/rm -f ${DMC_RUN_ONCE_FLAG}
fi



### prepare proxy.conf

NGINX_CONF_DIR="/etc/nginx/conf.d"
PROXY_TEMPLATE="${NGINX_CONF_DIR}/proxy.template"
PROXY_CONF="${NGINX_CONF_DIR}/proxy.conf"
PROXY_CUSTOM="${NGINX_CONF_DIR}/proxy.custom"

# copy conf file from custom file
if [ -f ${PROXY_CUSTOM} ]; then
    yes | cp -rf ${PROXY_CUSTOM} ${PROXY_CONF}

# copy conf file from template
elif [ -f ${PROXY_TEMPLATE} ]; then
    yes | cp -rf ${PROXY_TEMPLATE} ${PROXY_CONF}

    # prepare upstream var
    DMC_NGINX_APPUPSTREAM=${DMC_NGINX_APPUPSTREAM:-"server app:80;"}

    # replace env vars
    for i in _ {a..z} {A..Z}; do
        for ENV_VAR in `eval echo "\\${!$i@}"`; do
            if [ ${ENV_VAR} != 'ENV_VAR' ] && [ ${ENV_VAR} != 'i' ]; then
                sed -i "s/{{ \$${ENV_VAR} }}/${!ENV_VAR}/" ${PROXY_CONF}
            fi
        done
    done
fi




### run custom script if exists
CUSTOM_SCRIPT="${DMC_INSTALL_DIR}/custom.sh"
if [ -f ${CUSTOM_SCRIPT} ]; then
    chmod +x ${CUSTOM_SCRIPT} && source ${CUSTOM_SCRIPT}
fi
if [ ! -z "${DMC_CUSTOM_RUN_COMMAND}" ]; then
    eval ${DMC_CUSTOM_RUN_COMMAND}
fi



### FIX cron start
cron



### run supervisord
exec /usr/bin/supervisord -n
