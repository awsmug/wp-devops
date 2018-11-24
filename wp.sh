#!/bin/bash
##
# WP-CLI shortcut
##

export CURRENT_DIR=$(pwd)
export BIN_DIR="${CURRENT_DIR}/vendor/awsmug/wp-devops"

includes_dir="${BIN_DIR}/includes"

source ${includes_dir}/system.sh
source ${includes_dir}/docker.sh

docker exec -i $(dc wp) wp "$@"