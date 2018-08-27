#!/bin/bash

##
# WP-CLI shortcut
##
source $(dirname ${0})/includes/docker.sh

docker exec -i $(dc wp) wp "$@"