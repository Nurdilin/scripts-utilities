#!/bin/bash
#############################################################################
#usage example: ./mass_ssh_exec.sh "df -h"
##############################################################################
#assumption is that .ssh/config contains aliases of all the needed boxes
#in the following format
#
#Host 02
#  HostName hostexample002
#  User username
#Host 03
#  HostName hostexample003
#  User username
#
#
###############################################################################

for f in $(cat ~/.ssh/config | grep -i "Hostname" | awk '{print $2}'); do
	echo -e "\033[1;32m\n$(date) Connecting to: $f \033[0m";
	ssh -q $f "echo; hostname; $1"
        echo -e "\033[1;31m\n$(date) Disconnecting from: $f \n\n\033[0m";
done


#\033[1;32m is the code for green colour
#\033[1;31m is the code for red colour
#\033[0m resets the colour to default
#ssh -q suppress warnings while connecting to a box
