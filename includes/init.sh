#!/bin/bash

##
# Initializing devops
##
function _link_files {
    local BIN_DIR="$1"

    rm "$(pwd)"/devops.sh
    ln -s "${BIN_DIR}"/devops.sh "$(pwd)"/devops.sh

    rm "$(pwd)"/wp.sh
    ln -s "${BIN_DIR}"/wp.sh "$(pwd)"/wp.sh
}

##
# Copy config files
##
function _copy_files {
    local TEMPLATES_DIR="$1"

    CONFIG_TEMPLATE_DIR="${TEMPLATES_DIR}"/conf
    CONFIG_DIR="$(pwd)"/conf

    read -p "Do you want do develop a 'site', 'plugin' or 'theme'? (site) " DEV_TYPE

    mkdir -p "${CONFIG_DIR}"

    if [[ "plugin" == ${DEV_TYPE} ]]; then
        cp "${TEMPLATES_DIR}"/docker-compose-plugin.yml "${CONFIG_DIR}"/docker-compose.yml

        read -p "Do you want do add example plugin files? (yes|no) " EXAMPLE_PLUGIN_FILE

        if [[ "yes" == ${EXAMPLE_PLUGIN_FILE} ]]; then
            mkdir -p "$(pwd)/src/"
            cp "${TEMPLATES_DIR}"/plugin.php "$(pwd)"/src/my-new-plugin.php
        fi

    elif [[ "theme" == ${DEV_TYPE} ]]; then
        cp "${TEMPLATES_DIR}/docker-compose-theme.yml" "${CONFIG_DIR}/docker-compose.yml"

        read -p "Do you want do add example theme files? (yes|no) " EXAMPLE_THEME_FILE

        if [[ "yes" == ${EXAMPLE_THEME_FILE} ]]; then
            mkdir -p "$(pwd)/src/"
            cp "${TEMPLATES_DIR}/theme-style.css" "$(pwd)/src/style.css"
            cp "${TEMPLATES_DIR}/theme-index.php" "$(pwd)/src/index.php"
        fi

    elif [[ "site" == ${DEV_TYPE} ]]; then
        cp "${TEMPLATES_DIR}"/docker-compose-site.yml "${CONFIG_DIR}"/docker-compose.yml

    elif [[ "" == ${DEV_TYPE} ]]; then
        cp "${TEMPLATES_DIR}"/docker-compose-site.yml "${CONFIG_DIR}"/docker-compose.yml

    else
        echo "Wrong input!"
        rm -rf ${CONFIG_DIR}
        exit 1
    fi

    cp "${CONFIG_TEMPLATE_DIR}"/devops.conf "${CONFIG_DIR}"/devops.conf

    mkdir -p "${CONFIG_DIR}/nginx"
    cp "${CONFIG_TEMPLATE_DIR}"/nginx/default.conf "${CONFIG_DIR}"/nginx/default.conf
    cp "${CONFIG_TEMPLATE_DIR}"/nginx/nginx.conf "${CONFIG_DIR}"/nginx/nginx.conf

    mkdir -p "${CONFIG_DIR}/php"
    cp "${CONFIG_TEMPLATE_DIR}"/php/Dockerfile "${CONFIG_DIR}"/php/Dockerfile
    cp "${CONFIG_TEMPLATE_DIR}"/php/php.ini "${CONFIG_DIR}"/php/php.ini
    cp "${CONFIG_TEMPLATE_DIR}"/php/www.conf "${CONFIG_DIR}"/php/www.conf

    docker-compose -f "${CONFIG_DIR}"/docker-compose.yml --project-directory="$(pwd)" build
}

##
# Setting host
##
function _set_host {
    CONFIG_DIR="$(pwd)"/conf

    read -p "What will be the host name of this installation? (localhost) " LOCAL_HOST

    if [[ "" == ${LOCAL_HOST} ]]; then
        LOCAL_HOST=localhost
    fi

    REPLACE_LINE=$(cat ./conf/devops.conf | grep ^LOCAL_HOST)

    sed -i -e "s/^${REPLACE_LINE}/LOCAL_HOST=${LOCAL_HOST}/g" "${CONFIG_DIR}/devops.conf"
    rm "${CONFIG_DIR}/devops.conf-e"
}