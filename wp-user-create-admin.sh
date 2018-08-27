#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

source ${includes_dir}/system.sh

$(__DIR__)/wp.sh user create admin admin@site.com --role=administrator --user_pass=password