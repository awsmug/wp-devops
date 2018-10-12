#!/bin/bash

export bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
export includes_dir="${bin_dir}/includes"
export templates_dir="${bin_dir}/templates"

source ${includes_dir}/system.sh
source ${includes_dir}/docker.sh
source ${includes_dir}/devops-init.sh

##
# Advising scripts
##
if [ "$1" = "init" ]; then
    $(_link_files)
    $(_copy_config)
elif [ "$1" = "update" ]; then
    $(_link_files)
else
    echo "Usage: $(basename $0) <init|update>"
fi