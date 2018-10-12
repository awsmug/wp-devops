#!/bin/bash

##
# Initializing devops
##
function _link_files {
    local BIN_DIR=$1

    if [ -f "$(pwd)/devops.sh" ]; then
        rm "$(pwd)/devops.sh"
    fi

    ln -s "${BIN_DIR}/devops.sh" "$(pwd)/devops.sh"

    if [ -f "$(pwd)/wp.sh" ]; then
        rm "$(pwd)/wp.sh"
    fi

    ln -s "${BIN_DIR}/wp.sh" "$(pwd)/wp.sh"
}

##
# Copy config files
##
function _copy_files {
    local TEMPLATES_DIR=$1

    CONFIG_TEMPLATE_DIR="${TEMPLATES_DIR}/conf"
    CONFIG_DIR="$(pwd)/conf"

    cp "${TEMPLATES_DIR}/docker-compose.yml" "$(pwd)/docker-compose.yml"

    mkdir -p ${CONFIG_DIR}
    cp "${CONFIG_TEMPLATE_DIR}/db.conf" "${CONFIG_DIR}/db.conf"
    cp "${CONFIG_TEMPLATE_DIR}/ftp.conf" "${CONFIG_DIR}/ftp.conf"
    cp "${CONFIG_TEMPLATE_DIR}/server.conf" "${CONFIG_DIR}/server.conf"

    mkdir -p "${CONFIG_DIR}/nginx"
    cp "${CONFIG_TEMPLATE_DIR}/nginx/default.conf" "${CONFIG_DIR}/nginx/default.conf"
    cp "${CONFIG_TEMPLATE_DIR}/nginx/nginx.conf" "${CONFIG_DIR}/nginx/nginx.conf"

    mkdir -p "${CONFIG_DIR}/php"
    cp "${CONFIG_TEMPLATE_DIR}/php/Dockerfile" "${CONFIG_DIR}/php/Dockerfile"
    cp "${CONFIG_TEMPLATE_DIR}/php/php.ini" "${CONFIG_DIR}/php/php.ini"
    cp "${CONFIG_TEMPLATE_DIR}/php/www.conf" "${CONFIG_DIR}/php/www.conf"
}