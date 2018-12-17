#!/bin/bash

export PATH=$PATH:/bin:/usr/sbin/

date >> /logs/auto_empty_fd_$(date +%Y%m%d_%H).log 2>&1;

for line in $(lsof | grep username | grep deleted | grep logs | awk -v x=1000 '$7 >= x' | sed -r 's/(\s)+/#/g')
do
	pid=$(echo $line | awk -F "#" '{print $2}')
	fd=$(echo $line | awk -F "#" '{print $4}'| grep -o -E [0-9]+)
	echo "Emptying /proc/$pid/fd/$fd"
	cat /dev/null > /proc/$pid/fd/$fd 
done >> /logs/auto_empty_fd_$(date +%Y%m%d_%H).log 2>&1

