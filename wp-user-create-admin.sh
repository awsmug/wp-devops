#!/bin/bash

source $(dirname ${0})/includes/system.sh

 $(__DIR__)/wp.sh user create admin admin@site.com --role=administrator --user_pass=password