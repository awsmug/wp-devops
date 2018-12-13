#!/bin/bash

##
# Starting environment
##
_start() {
    CONF_DIR="$(pwd)/conf"
    devops_conf="${CONF_DIR}/devops.conf"

    source "${devops_conf}"
    export LOCAL_HOST=${LOCAL_HOST}

    docker-compose -f "${CONF_DIR}"/docker-compose.yml --project-directory="$(pwd)" build

    if [ "$1" = "logs" ]; then
        docker-compose -f "${CONF_DIR}"/docker-compose.yml --project-directory="$(pwd)" up -d
    else
        docker-compose -f "${CONF_DIR}"/docker-compose.yml --project-directory="$(pwd)" up
    fi

    _add_host ${LOCAL_HOST}
}

##
# Stopping environment
##
_stop() {
    CONF_DIR="$(pwd)/conf"
    devops_conf="${CONF_DIR}/devops.conf"

    source "${devops_conf}"
    export LOCAL_HOST=${LOCAL_HOST}

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