#!/bin/bash

network=192.168.1.

for i in $(seq 0 255)
do
	address=$network$i
	echo "Investigating $address"
	host $address
	echo -e "\n"

done

