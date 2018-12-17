#!/bin/bash

#
#Find the path where the bash script is located
#
# source it and run in in another script
# . ./func_get_scripts_path.sh
#
# USAGE:
# my_variable=$(_get_scripts_path) 

function _get_scripts_path {

	script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	echo $script_dir
}

#_get_scripts_path
