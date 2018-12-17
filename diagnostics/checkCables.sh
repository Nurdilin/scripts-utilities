#!/bin/bash

for f in $( ls /sys/class/net ); do 
	echo -n $f: ;
	cat /sys/class/net/$f/carrier;
done

