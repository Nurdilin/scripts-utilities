#!/bin/bash

#
#Find the path where the bash script is located
#
# source it and run in in another script
# . ./func_prevent_running_from_outside_script_s_location.sh
#
# USAGE:
# _prevent_running_from_outside_script_s_location

function _prevent_running_from_outside_script_s_location {
	script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	echo "script path : $script_path"
	echo "current path: $(pwd)"
	if [[ $(pwd) != "$script_path" ]]; then
		"Script's path and current path do not match. Exiting"
		exit -1
	fi
}

_prevent_running_from_outside_script_s_location
