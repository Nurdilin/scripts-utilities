#!/bin/bash

# source it and run in in another script
# . ./functions/func_check_for_route.sh

function _root_check {
	if [ $UID -ne 0 ]; then
		echo "not root user"
	else
		echo "root user"
	fi
	return $UID #0 for root aka true, non-0 for other user aka false	
}

#_root_check

