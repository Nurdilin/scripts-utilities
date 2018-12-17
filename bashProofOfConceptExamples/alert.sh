#!/bin/bash
#./alert.sh full_space_threshold full_space_threshold_for_deletion
#eg ./alert.sh 80 90 will send an alert if the full space exceeds 80% and will start removing logs if it exceeds 90%

space=$(df /logs/company | grep logs\/company|awk '{print $4}' |sed 's/%//')

if [ $space -gt $2 ] ; then
	#TODO mail notification
	#echo "$(date) Your log server remaining free space is critically low. Deleting some logs... "| mailx -s "hostnameABC - log server - Disk Space Critical Alert " example@ex.com
	echo "$(date) Your log server remaining free space is critically low. Deleting some logs.." >> /logs/company/cronjobs.logs
	./log_cleanup.sh /logs/company/test1/ +21
	./log_cleanup.sh /logs/company/test2/ +21
elif [ $space -gt $1 ] ; then
	#TODO mail notification
	#echo "$(date) Your log server remaining free space is low "| mailx -s "box01 - log server - Disk Space Alert" company-infrastructure@company.com
	echo "$(date) Your log server remaining free space is low." >> /logs/company/cronjobs.logs
fi


