#!/bin/bash

if [ ! -f "$(pwd)/docker-compsoe.yml" ]; then
    $(_file_not_exists "docker-compose.yml")
    exit 1
fi

docker-compose down