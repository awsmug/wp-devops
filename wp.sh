#!/bin/bash

##
# WP-CLI shortcut
##
source "includes-dir.sh"
source ${includes_dir}/system.sh
source ${includes_dir}/docker.sh

docker exec -i $(dc wp) wp "$@"