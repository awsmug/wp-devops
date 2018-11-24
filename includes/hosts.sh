#!/bin/bash

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts

# DEFAULT IP FOR HOSTNAME
IP="127.0.0.1"

function _remove_host() {
    HOST_NAME="$1"

    if [ -n "$(grep $HOST_NAME /etc/hosts)" ]
    then
        echo "$HOST_NAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOST_NAME/d" $ETC_HOSTS
    else
        echo "$HOST_NAME was not found in your $ETC_HOSTS";
    fi
}

function _add_host() {
    HOST_NAME="$1"
    HOSTS_LINE="$IP\t$HOST_NAME"
    if [ -n "$(grep $HOST_NAME /etc/hosts)" ]
        then
            echo "$HOST_NAME already exists : $(grep $HOST_NAME $ETC_HOSTS)"
        else
            echo "Adding $HOST_NAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOST_NAME /etc/hosts)" ]
                then
                    echo "$HOST_NAME was added succesfully \n $(grep $HOST_NAME /etc/hosts)";
                else
                    echo "Failed to Add $HOST_NAME, Try again!";
            fi
    fi
}