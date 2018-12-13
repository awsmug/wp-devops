#!/bin/bash

##
# Imports a dump to db
##
_db_import() {
    sql_dump=${1}

    if [ -z ${sql_dump} ]; then
        echo $(_missing_param "2" "devops.sh dbimport [SQL_FILE]")
        exit
    fi

    if [ ! -f ${sql_dump} ]; then
        echo $(_file_not_exists ${sql_dump})
        exit
    fi

    devops_conf=${CONF_DIR}"/devops.conf"

    source ${devops_conf}

    read -p "This will drop all database data of the local installation and will replace it by new data. Are you really sure? (y/N) " i_am_sure

    if [[ ${i_am_sure} != "y" ]]; then
        "Exited import before starting."
        exit
    fi

    backup_filename="db-backup-$(_date_string).sql"

    echo "Backup old data to db-backup-$(_date_string).sql..."
    docker exec $(dc db) mysqldump -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS} ${DB_LOCAL_NAME} > data/${backup_filename}

    echo "Dropping old database \"${DB_LOCAL_NAME}\"..."
    docker exec $(dc db) mysql -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS}  --database="${DB_LOCAL_NAME}" --execute="DROP DATABASE ${DB_LOCAL_NAME}; CREATE DATABASE ${DB_LOCAL_NAME};"

    echo "Importing new database from ${sql_dump} to database \"${DB_LOCAL_NAME}\"..."
    cat ${sql_dump} | docker exec -i $(dc db) mysql -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS} ${DB_LOCAL_NAME}

    echo "Search and replace \"${REMOTE_URL}\" with \"${LOCAL_URL}\" in WordPress database..."
    docker exec $(dc wp) wp search-replace "${REMOTE_URL}" "${LOCAL_URL}"

    echo "Finished!"

    read -n1 -r -p "Press any key to continue..." key
}

##
# Imports a dump to db
##
_db_export() {
    sql_dump=${1}

    if [ -z ${sql_dump} ]; then
        echo $(_missing_param "2" "devops.sh dbexport [SQL_FILE]")
        exit
    fi

    devops_conf=${CONF_DIR}"/devops.conf"
    source ${devops_conf}

    docker exec $(dc db) mysqldump -u ${DB_LOCAL_USER} --password=${DB_LOCAL_PASS} ${DB_LOCAL_NAME} > ${sql_dump}
}
