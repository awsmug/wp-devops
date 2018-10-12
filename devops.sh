#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

rm "$(pwd)/server.sh"
ln -s "${bin_dir}/server.sh" "$(pwd)/server.sh"

rm "$(pwd)/wp.sh"
ln -s "${bin_dir}/wp.sh" "$(pwd)/wp.sh"