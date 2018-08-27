#!/bin/bash

script_dir=$(dirname ${0})

source ${script_dir}/includes/docker.sh

${script_dir}/sync-down-db ${1}
${script_dir}/sync-down-uploads

git pull