#!/bin/bash
##
# WP-CLI shortcut
##

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

source ${includes_dir}/system.sh
source ${includes_dir}/docker.sh

docker exec -i $(dc wp) wp "$@"