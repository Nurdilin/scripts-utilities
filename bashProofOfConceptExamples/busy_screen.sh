#!/bin/bash

# turn off globbing
set -f

#Discard errors 
exec 2> /dev/null
#exec 2>&1 #if i want to "enable" them again

# IFS stands for "internal field separator". 
# It is used by the shell to determine how to do word splitting
# aka how to recognize word boundaries.
#
# eg IFS=: split only on :
# split on newlines only instead of default space, tab and newline
IFS=$'\n'

for file in $(find /var/log -type f); do
	if [ $(file $file | grep text | wc -l) -ne 0 ]; then
		#echo $file
		for line in $(cat $file); do
      			echo $line
      			sleep 0.$(( RANDOM % 10 ))
    		done
	fi
done
