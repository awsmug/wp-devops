#!/bin/bash

script_file=${0}
script_dir=$(dirname ${script_file})

if [ "bin" != $(dirname ${script_file})  ]; then
    echo "Please enter the main project directory to execute project commands."
    echo $(dirname ${script_file})
    exit
fi

source conf/ftp.conf

${script_dir}/ftp download ${FTP_PATH}/wp-content/uploads/ src/wp-content/uploads/