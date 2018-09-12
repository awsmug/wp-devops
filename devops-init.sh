#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

ln "${bin_dir}/wp.sh" "$(pwd)/wp.sh"
ln "${bin_dir}/wp-user-create-admin.sh" "$(pwd)/wp-user-create-admin.sh"

ln "${bin_dir}/import-db.sh" "$(pwd)/import-db.sh"

project_name=$(basname $(pwd))

ln "${bin_dir}/webserver-start.sh" "${HOME}/desktop/${project_name}-start"
ln "${bin_dir}/webserver-stop.sh" "${HOME}/desktop/${project_name}-stop"
