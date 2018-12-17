#!/bin/bash

function _read_default () {
        read -p "Enter $1 ($2): " VAR
        export $1=${VAR:-$2}

        varname=$1
        echo "$1 = ${!varname}"
        echo
}

#Usage
#_read_default USERNAME        testbot
#echo $USERNAME
