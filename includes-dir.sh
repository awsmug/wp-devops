#!/bin/bash

if [ -d "./includes" ]; then
    includes_dir=$(dirname ${0})/includes/
else
    includes_dir=$(dirname $(dirname ${0}))/awsmug/dev-bash-wp-docker/includes/
fi