#!/bin/bash

##
# Starting environment
##
_start() {
    if [ ! -f "$(pwd)/docker-compose.yml" ]; then
        $(_file_not_exists "docker-compose.yml")
        echo "Please run setup.sh before launching."
        exit 1
    fi

    docker-compose up
}

##
# Stopping environment
##
_stop() {
    if [ ! -f "$(pwd)/docker-compose.yml" ]; then
        $(_file_not_exists "docker-compose.yml")
        echo "Please run setup.sh before launching."
        exit 1
    fi

    docker-compose down
}

