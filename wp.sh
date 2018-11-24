#!/bin/bash
##
# WP-CLI shortcut
##

export CURRENT_DIR="$(pwd)"
export BIN_DIR="${CURRENT_DIR}/vendor/awsmug/wp-devops"
export INCLUDES_DIR="${BIN_DIR}/includes"

source "${INCLUDES_DIR}/system.sh"
source "${INCLUDES_DIR}/docker.sh"

docker exec -i $(dc wp) wp "$@"