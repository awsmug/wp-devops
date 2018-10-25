#!/bin/bash

export BIN_DIR="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
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
    _copy_files ${TEMPLATES_DIR}
    echo "Finished copying config files."

    _link_files ${BIN_DIR}
    echo "Finished linking command files."

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
# Help on wrong usage
##
else
    echo "Usage: $(basename $0) <init|update|up|down|restart|dbimport [filename]>"
fi