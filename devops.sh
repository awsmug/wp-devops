#!/bin/bash

export BIN_DIR="$(pwd)/vendor/awsmug/wp-devops/"
export CONF_DIR="$(pwd)/conf"
export INCLUDES_DIR="${BIN_DIR}/includes"
export TEMPLATES_DIR="${BIN_DIR}/templates"

source ${INCLUDES_DIR}/system.sh
source ${INCLUDES_DIR}/db.sh
source ${INCLUDES_DIR}/init.sh
source ${INCLUDES_DIR}/docker.sh
source ${INCLUDES_DIR}/server.sh

##
# Initializing devops
##
if [ "$1" = "init" ]; then
    if [ -z "$2" ]; then
        _missing_param "2" "devops init [all|links|files]"
    fi

    if [ "$2" = "all" ]; then
        _copy_files ${TEMPLATES_DIR}
        echo "Finished copying config files."

         _link_files ${BIN_DIR}
        echo "Finished linking command files."
    fi

    if [ "$2" = "links" ]; then
         _link_files ${BIN_DIR}
        echo "Finished linking command files."
    fi

    if [ "$2" = "files" ]; then
         _link_files ${BIN_DIR}
        echo "Finished linking command files."
    fi

##
# Updating devops
##
elif [ "$1" = "update" ]; then
    docker-compose -f "${CONF_DIR}/docker-compose.yml" --project-directory=$(pwd) pull
    docker-compose -f "${CONF_DIR}/docker-compose.yml" --project-directory=$(pwd) build
    composer update awsmug/wp-devops
    _link_files ${BIN_DIR}
    echo "Finished updating devops."

##
# Starting server
##
elif [ "$1" = "up" ]; then
    _start

##
# Stopping server
##
elif [ "$1" = "down" ]; then
    _stop

##
# Stopping server
##
elif [ "$1" = "restart" ]; then
    _restart

##
# Import db
##
elif [ "$1" = "dbimport" ]; then
   _db_import $2

##
# Import db
##
elif [ "$1" = "env" ]; then
   echo "BIN_DIR: ${BIN_DIR}"
   echo "CONF_DIR: ${CONF_DIR}"
   echo "INCLUDES_DIR: ${INCLUDES_DIR}"
   echo "TEMPLATES_DIR: ${TEMPLATES_DIR}"

##
# Help on wrong usage
##
else
    echo "Usage: $(basename $0) <init|update|up|down|restart|dbimport [filename]>"
fi