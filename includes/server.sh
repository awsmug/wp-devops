#!/bin/bash

##
# Starting environment
##
_start() {
    CONF_DIR="$(pwd)"/conf
    devops_conf=${CONF_DIR}"/devops.conf"

    source ${devops_conf}
    docker-compose -f "${CONF_DIR}"/docker-compose.yml --project-directory="$(pwd)" up -d

    _add_host ${LOCAL_HOST}
}

##
# Stopping environment
##
_stop() {
    CONF_DIR="$(pwd)/conf"
    devops_conf=${CONF_DIR}"/devops.conf"

    source ${devops_conf}
    docker-compose -f "${CONF_DIR}"/docker-compose.yml --project-directory="$(pwd)" down
    _remove_host ${LOCAL_HOST}
}

##
# Restarting environment
##
_restart() {
    _stop
    _start
}