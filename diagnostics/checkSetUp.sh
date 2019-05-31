#!/bin/bash

YES=$(/usr/bin/printf "\033[1;32m\xE2\x9C\x94\033[0m")
NO=$(/usr/bin/printf "\033[1;31m\xE2\x9C\x95\033[0m")

#echo $YES $NO

echo "Running on server: $(hostname -s)"


echo "
===================================================
== Checking the follow directories exits ==
===================================================
"

DIRS=$(echo "
/opt/example/.ssh
/logs/
/logs/example/db
/opt/example
")

for DIR in ${DIRS}; do
	if [[ -d $DIR ]] ; then
		echo "$YES  -  $DIR"
	else
		echo "$NO   -  $DIR"
	fi 
done

echo "
===================================================
== Checking rpc services up and running (expect7)==
===================================================
"

sc=$(rpcinfo -p | wc -l)

if [[ "$sc" -eq 7 ]]; then
	echo "$YES  -  rpc services"
else
	echo "$NO  -   rpc services"
fi



echo "
===================================================
== Checking Packages                             ==
===================================================
"

_CheckPkg() {
	pPkg=$1
	pState=$2

        if [[ "$pState" == "absent" ]]; then
                rpm -q "$pPkg" 1>/dev/null 2>&1
                if [[ $? -eq 0 ]]; then echo "$NO  -   $pPkg"; fi
        else
                rpm -q $pPkg 1>/dev/null 2>&1
                if [[ $? -eq 0 ]]; then echo "$YES  -   $pPkg"; fi
        fi
}


_CheckPkg java-1.7.0-openjdk              absent
_CheckPkg java-1.7.0-openjdk-devel        absent
_CheckPkg jre-1.7.0_60
_CheckPkg tdom-0.8.2-6.el6.example4
_CheckPkg tbcload-1.7-6.el6.example
_CheckPkg libev-4.03-3.el6
_CheckPkg rpcbind
_CheckPkg nfs-utils



echo "
====================================================
== Check  zip/gz etc have been removed            ==
====================================================
"

Apps="
/opt/apache-tomcat-7.0.54.tar.gz
/opt/informix-3.70.FC8W1.tar.gz
"

for APP in ${Apps}; do

        if [[ -f $APP ]]; then 
        	echo "$NO  -  $APP"
	else
		echo "$YES  -  $APP"
	fi
done


echo "
====================================================
== Checking Links to files/directories            ==
====================================================
"

function _CheckLink {

    local pFile=${1}
    local pLink=${2}
    local Link="$( readlink ${pFile%/} )"


    if [[ "${Link%/}"  == "${pLink%/}" ]]; then
   	 echo "$YES  -   ${pFile} -> ${pLink}"
    else
    	echo "$NO  -   ${pFile} -> ${pLink}"
    fi
    return
}


_CheckLink /usr/bin/java /usr/java/default/bin/java  	
_CheckLink /opt/tomcat/ /opt/apache-tomcat-7.0.54/  	


echo "
====================================================
== Checking Mounts                                ==
====================================================
"

_CheckMount() {

    local pContent=${1}
    
    if [[ $(mount | grep $pContent | wc -l) -gt 0 ]]; then
	echo "$YES  -  $pContent"
    else
	echo "$NO  -  $pContent"
    fi
    return
}

_CheckMount /example

