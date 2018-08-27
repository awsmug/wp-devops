#!/bin/bash

##
# Prints current filename
##
__FILE__() {
    echo "$(pwd)/${0}"
}

##
# Prints current filename
##
__DIR__() {
    echo $(dirname $(__FILE__))
}

##
# Printing out Error
##
_error() {
    echo "Error in $(__FILE__):${LINENO}. ${1}"
}
##
# Echos wrong syntax
##
_wrong_syntax() {
    syntax=${1}
    echo $(_error "Wrong input! Correct syntax is: ${syntax}.")
}

##
# Echos wrong directory
##
_dir_not_exists() {
    syntax=${1}
    echo $(_error "The path \"${1}\" does not exist.")
}

##
# Echos wrong directory
##
_file_not_exists() {
    syntax=${1}
    echo $(_error "The file \"${1}\" does not exist.")
}

##
# Echos a date string for use in files
##
_date_string() {
    echo $(date +%Y-%m-%d-%H-%M-%S)
}