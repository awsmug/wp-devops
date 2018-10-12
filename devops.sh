#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

rm "$(pwd)/server.sh"
ln -s "${bin_dir}/server.sh" "$(pwd)/server.sh"

rm "$(pwd)/wp.sh"
ln -s "${bin_dir}/wp.sh" "$(pwd)/wp.sh"

#rm "$(pwd)/wp-user-create-admin.sh"
#ln -s "${bin_dir}/wp-user-create-admin.sh" "$(pwd)/wp-user-create-admin.sh"

#rm "$(pwd)/sync.sh"
#ln -s "${bin_dir}/sync.sh" "$(pwd)/sync.sh"

#project_name=$(basename $(pwd))

#rm "${HOME}/desktop/${project_name}-start"
#ln -s "${bin_dir}/webserver-start.sh" "${HOME}/desktop/${project_name}-start"

#rm "${HOME}/desktop/${project_name}-stop"
#ln -s "${bin_dir}/webserver-stop.sh" "${HOME}/desktop/${project_name}-stop"
#ln -s "${bin_dir}/webserver-stop.sh" "${HOME}/desktop/${project_name}-stop"
