#!/bin/bash

bin_dir="$(linked_file=$(readlink ${0}) && cd $(cd $(dirname ${0}) && echo $(pwd)) && cd $(dirname ${linked_file}) && echo $(pwd))"
includes_dir="${bin_dir}/includes"

source ${includes_dir}/docker.sh
source ${includes_dir}/system.sh

script_file=$(__FILE__)
script_dir=$(__DIR__)

conf_dir=${1}
sql_dump=${2}

if [ -z ${conf_dir} ]; then
    echo $(_wrong_syntax "import-db.sh [CONFIG_DIR] [SQL_FILE]")
    exit
fi

if [ -d ${conf_dir} ]; then
    db_conf=${conf_dir}"/db.conf"
    server_conf=${conf_dir}"/server.conf"

    if [ -f ${server_conf}  ]; then
        source ${server_conf}
    else
        echo $(_file_not_exists ${conf_dir})
        exit
    fi

    if [ -f ${db_conf}  ]; then
        source ${db_conf}
    else
        echo $(_file_not_exists ${db_conf})
        exit
    fi
else
    echo $(_dir_not_exists ${conf_dir})
    exit
fi

if [ -z ${sql_dump}  ]; then
    echo $(_wrong_syntax "import-db.sh [CONFIG_DIR] [SQL_FILE]")
    exit
fi

if [ ! -f ${sql_dump} ]; then
    echo $(_file_not_exists ${sql_dump})
    exit
fi

echo "This will drop all database data of the local installation and will replace it by new data. Are you really sure? (y/N)"
read i_am_sure

if [ ${i_am_sure} != "y" ]; then
    "Exited import before starting."
    exit
fi

backup_filename="db-backup-$(_date_string).sql"

echo "Backup old data to db-backup-$(_date_string).sql..."
docker exec $(dc db) mysqldump -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS} ${DB_LOCAL_NAME} > data/${backup_filename}

echo "Dropping old database \"${DB_LOCAL_NAME}\"..."
docker exec $(dc db) mysql -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS}  --database="${DB_LOCAL_NAME}" --execute="DROP DATABASE ${DB_LOCAL_NAME}; CREATE DATABASE ${DB_LOCAL_NAME};"

echo "Importing new database from ${sql_dump} to database \"${DB_LOCAL_NAME}\"..."
docker cp ${sql_dump} $(dc db):/
docker exec -i $(dc db) mysql -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS} --database="${DB_LOCAL_NAME}" < $(pwd)/${sql_dump}

echo "Search and replace \"${REMOTE_URL}\" with \"${LOCAL_URL}\" in WordPress database..."
docker exec $(dc wp) wp search-replace "${REMOTE_URL}" "${LOCAL_URL}"

echo "Finished!"