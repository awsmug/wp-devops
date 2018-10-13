#!/bin/bash

##
# Starting environment
##
_start() {
    CONFIG_DIR="$(pwd)/conf"
    docker-compose -f "${CONFIG_DIR}/docker-compose.yml" --project-directory=$(pwd) up -d
}

##
# Stopping environment
##
_stop() {
    CONFIG_DIR="$(pwd)/conf"
    docker-compose -f "${CONFIG_DIR}/docker-compose.yml" --project-directory=$(pwd) down
}

##
# Restarting environment
##
_restart() {
    $(_stop)
    $(_start)
}

