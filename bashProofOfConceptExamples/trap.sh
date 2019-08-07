#!/bin/bash

function _function_do_smt {
	echo "argument of functions $1"
}
#trap "echo signal trapped" SIGINT SIGTERM
trap "_function_do_smt arg1lol" SIGTERM SIGINT

while true ; do
	sleep 1
	echo "slept for 1 and will wait for 1"
done
