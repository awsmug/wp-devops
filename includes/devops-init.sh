#!/bin/bash

##
# Initializing devops
##
_link_files() {
    if [ -f "$(pwd)/server.sh" ]; then
        rm "$(pwd)/server.sh"
    fi

    ln -s "${bin_dir}/server.sh" "$(pwd)/server.sh"

    if [ -f "$(pwd)/wp.sh" ]; then
        rm "$(pwd)/wp.sh"
    fi

    ln -s "${bin_dir}/wp.sh" "$(pwd)/wp.sh"
}

##
# Copy config files
##
_copy_config() {
    if [ -f "$(pwd)/docker-compose.yml" ]; then
        echo $(_file_already_exists "$(pwd)/docker-compose.yml")
        echo "To re-init config files, please delete the $(pwd)/docker-compose.yml and rerun script."
        exit 1
    fi

    config_template_dir="${templates_dir}/conf"
    config_dir="$(pwd)/conf"

    cp "${templates_dir}/docker-compose.yml" "$(pwd)/docker-compose.yml"

    mkdir -p ${config_dir}
    cp "${config_template_dir}/db.conf" "${config_dir}/db.conf"
    cp "${config_template_dir}/ftp.conf" "${config_dir}/ftp.conf"
    cp "${config_template_dir}/server.conf" "${config_dir}/server.conf"

    mkdir -p "${config_dir}/nginx"
    cp "${config_template_dir}/nginx/default.conf" "${config_dir}/nginx/default.conf"
    cp "${config_template_dir}/nginx/nginx.conf" "${config_dir}/nginx/nginx.conf"

    mkdir -p "${config_dir}/php"
    cp "${config_template_dir}/php/Dockerfile" "${config_dir}/php/Dockerfile"
    cp "${config_template_dir}/php/php.ini" "${config_dir}/php/php.ini"
    cp "${config_template_dir}/php/www.conf" "${config_dir}/php/www.conf"

    echo "Finished copying configuration files."
}