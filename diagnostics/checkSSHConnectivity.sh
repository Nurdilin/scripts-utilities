#!/bin/bash

for server in $(cat ~/.ssh/config | grep -i "Hostname" | awk '{print $2}'); 
do 
	echo "Trying $server..."
	ssh -q -o ConnectTimeout=5 $server ' \
		echo -e "    \e[32mConnected!\e[0m"; \
	';
	if [ ! $? -eq 0 ]; then
		echo -e "    \e[31mFailed\e[0m";
	fi
	echo ""
done
