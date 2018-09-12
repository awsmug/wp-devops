#!/bin/bash

if [ ! -f "$(pwd)/docker-compose.yml" ]; then
    $(_file_not_exists "docker-compose.yml")
    exit 1
fi

docker-compose up