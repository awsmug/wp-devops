#!/bin/bash

source "includes-dir.sh"
source ${includes_dir}/system.sh

$(__DIR__)/wp.sh user create admin admin@site.com --role=administrator --user_pass=password