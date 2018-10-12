#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

if [ "$1" = "init" ]; then
    if [ -f "$(pwd)/server.sh" ]; then
        rm "$(pwd)/server.sh"
    fi

    ln -s "${bin_dir}/server.sh" "$(pwd)/server.sh"

    if [ -f "$(pwd)/wp.sh" ]; then
        rm "$(pwd)/wp.sh"
    fi

    ln -s "${bin_dir}/wp.sh" "$(pwd)/wp.sh"
else
    echo "Usage: $(basename $0) <init>"
fi