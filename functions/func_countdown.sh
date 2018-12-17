#!/bin/bash

# source it and run in in another script
# . ./functions/func_countdown.sh
# _countdown #secs

function _countdown {

        if (($# != 1)) || [[ $1 = *[![:digit:]]* ]]; then
                echo "Usage: countdown seconds"
                return
        fi

	local t=$1 remaining=$1;
        ##################################################### 
        # SECONDS (special variable)                        # 
        # The number of seconds the script has been running #
        ##################################################### 

        SECONDS=0;

        while sleep 1; do
                printf "\033[0K\rseconds remaining to proceed: $remaining"

                if (( (remaining=t-SECONDS) <=0 )); then
                        break;
                fi
        done
}

#_countdown 100

