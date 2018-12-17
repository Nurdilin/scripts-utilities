#!/bin/bash
#bash to check ping and port status.

function _Ping() {

	cat $CFG_FILE | while read line
	do
		server=$(echo $line | cut -d : -f2)

		ping -i 2 -c 2 $server > /dev/null 2>&1

		if [[ $? -eq 0 ]] ; then
			echo "$TIME : Status Of Host $server = $UP";
		else
			echo "$TIME : Status Of Host $server = $DOWN";
		fi
	done
}

function _Port_Scan() {

	cat $CFG_FILE | while read line
	do
		server=$(echo $line | cut -d : -f2)   #alternative: server=$(echo $line | awk -F ":" '{print $2}')
		port=$(echo $line | cut -d : -f3)

		#Maximum time in seconds that you allow the whole operation to take.  This is useful for preventing your batch jobs from hanging
		#for hours due to slow networks or links going down. 

		curl -m 1 $server:$port > /dev/null 2>&1

		if [[ $? -eq 0 ]]; then
			echo -e "$TIME : Port $port of URL http://$server:$port/ is $OPEN";
		else
			echo -e "$TIME : Port $port of URL http://$server:$port/ is $CLOSED";
		fi
	done
}

export CFG_FILE="./check_connectivity.cfg"
export TIME=$(date +%d-%m-%Y_%H.%M.%S)
export UP=$(echo -e "\033[32m[ RUNNING ]\033[0m")
export DOWN=$(echo -e "\033[31m[ DOWN ]\033[0m")
export OPEN=$(echo -e "\033[32m[ OPEN ]\033[0m")
export CLOSED=$(echo -e "\033[31m[ NOT OPEN ]\033[0m")
export LOG="$(basename $0).log"

_Ping | tee -a $LOG
_Port_Scan | tee -a $LOG
