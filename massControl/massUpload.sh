#!/bin/bash

declare -a arr=("10.33.104.170" 
"xx.xx.129.169" 
"xx.xx.129.170" 
"xx.xx.129.171" 
"xx.xx.129.172" 
"xx.xx.132.170" 
"xx.xx.132.171" )

for i in "${arr[@]}"
do
   echo "Pushing File to $i"
   sshpass -p $MY_PASS scp $1 $MY_USER@$i:/home/my_username   
done

