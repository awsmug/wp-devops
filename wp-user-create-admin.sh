#!/bin/bash

includes_dir="$(cd $(dirname $(readlink ${0})) && pwd)/includes"
source ${includes_dir}/system.sh

$(__DIR__)/wp.sh user create admin admin@site.com --role=administrator --user_pass=password