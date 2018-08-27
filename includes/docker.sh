#!/bin/bash

dc() {
    if [ -z  $1  ]; then
        echo "Missing docker container service name (e.g. web, php etc.)."
        exit
    fi

    PREFIX=$(pwd)
    PREFIX=$(basename ${PREFIX})
    PREFIX=${PREFIX// /}
    PREFIX=${PREFIX//./}

    echo ${PREFIX}_${1}_1
}

di_exists() {
    if [ -z  $1  ]; then
        echo "Missing docker image name (e.g. myimage:mytag)."
        exit
    fi

    if [[ "$(docker images -q ${1} 2> /dev/null)" == "" ]]; then
        echo true
        exit
    fi

    echo false
    exit
}