#!/usr/bin/env bash
#
# This file has executed after container's builds
#
# tech-stack: ubuntu / nginx
#
# @author demmonico
# @image ubuntu-nginx
# @version v2.0



### run custom script if exists
CUSTOM_ONCE_SCRIPT="${INSTALL_DIR}/custom_once.sh"
if [ -f ${CUSTOM_ONCE_SCRIPT} ]; then
    chmod +x ${CUSTOM_ONCE_SCRIPT} && source ${CUSTOM_ONCE_SCRIPT}
fi
