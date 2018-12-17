#!/bin/bash

# source it and run in in another script
# . ./functions/func_date.sh

function _date {
	TIME=$(date +%d-%m-%Y_%H.%M.%S)
	echo $TIME
}

#_date

