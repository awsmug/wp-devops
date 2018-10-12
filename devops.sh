#!/bin/bash

export bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
export includes_dir="${bin_dir}/includes"
export templates_dir="${bin_dir}/templates"

source ${includes_dir}/system.sh
source ${includes_dir}/init.sh
source ${includes_dir}/docker.sh
source ${includes_dir}/server.sh

##
# Initializing devops
##
if [ "$1" = "init" ]; then
    $(_init_conf_files)
    $(_link_files)

##
# Updating devops
##
elif [ "$1" = "update" ]; then
    $(composer update awsmug/wp-devops)
    $(_link_files)

##
# Starting server
##
elif [ "$1" = "up" ]; then
    $(_start)

##
# Stopping server
##
elif [ "$1" = "down" ]; then
    $(_stop)

##
# Help on wrong usage
##
else
    echo "Usage: $(basename $0) <init|update|up|down>"
fi