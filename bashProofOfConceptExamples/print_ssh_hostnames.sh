#!/bin/bash

# It checks whether the i option is present, i.e. whether the current shell is interactive.

if [[ $- =~ "i" ]] && [[ -f ~/.ssh/config ]]; then
    echo -e "\nSSH Aliases:\n------------"
    grep -i host ~/.ssh/config |paste - -| sed 's/HostName/-->/' |sed 's/Host\t//'
    echo -ne "\n"
fi
