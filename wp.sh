#!/bin/bash

##
# WP-CLI shortcut
##
includes_dir="$(cd $(dirname $(readlink ${0})) && pwd)/includes"

source ${includes_dir}/system.sh
source ${includes_dir}/docker.sh

docker exec -i $(dc wp) wp "$@"