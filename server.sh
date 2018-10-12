#!/bin/bash

if [ ! -f "$(pwd)/docker-compose.yml" ]; then
    $(_file_not_exists "docker-compose.yml")
    echo "Please run setup.sh before launching."
    exit 1
fi

if [ "$1" = "start" ]; then
    docker-compose up

elif [ "$1" = "stop" ]; then
    docker-compose down
else
   echo "Usage: $(basename $0) <start|stop>"
   exit 1
fi

