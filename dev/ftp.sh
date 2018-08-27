#!/bin/bash

##
# Stopped developing that script, because FTP client ist much too slow
#
# 2018-08-27
##

script_file=${0}
script_dir=$(dirname ${script_file})

if [ "bin" != $(dirname ${script_file})  ]; then
    echo "Please enter the main project directory to execute project commands."
    echo $(dirname ${script_file})
    exit
fi

source ${script_dir}/includes/docker.sh
source conf/ftp.conf

if [ -z ${1} ]; then
    echo "Missing first parameter (download/upload) to execute command."
    exit
fi

if [ -z ${2} ]; then
    echo "Missing second parameter (ftp directory) to execute command."
    exit
fi


if [ -z ${3} ]; then
    echo "Missing third parameter (local directory) to execute command."
    exit
fi

command=${1}
ftp_dir=${2}
local_dir=${3}

if [ ! -d ${local_dir} ]; then
    echo "Local directory does not exist."
    exit
fi

if [ ${command} = "upload" ]; then
    command="mput *"
elif [ ${command} = "download" ]; then
    command="mget -c -d *"
else
    echo "First parameter must be upload or downlod."
    exit
fi

cd ${local_dir}

lftp -u ${FTP_USER},${FTP_PASS} ${FTP_HOST} << EOF
set ssl:verify-certificate no
cd ${ftp_dir}
${command}
exit
EOF