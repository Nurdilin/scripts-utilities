#!/bin/bash
# usage: sync_lbr_apache_handlers.sh webserver1 webserver2 etc
#        sync_lbr_apache_handlers.sh --restart webserver1 webserver2 etc (to restart apache as well)
#
# Copies apache conf from the build into the webserver(s)
# 
# Assumes there is passwordless login between machines

# Exit on error
set -e

CONF_FILE="test.conf"
LOG="/home/logs/sync_web.log.`date +'%Y%m%d_%H'`"
USER=username
TEMP_STATIC_DIR="tmp_apache_conf"
APACHE_CONF="/var/www/vhosts/webserver01.com/conf/"
restart=0
SYNC_SRC="/home/conf-apache"

#parse through all script arguments
for WEBSERV in "$@"
do

	#if the option for restart was used turn the restart flag on
	if [ "$WEBSERV" == "--restart" ]; then
		restart=1; 
		continue;
	fi

	DESTINATION="$USER@$WEBSERV"
		
	SYNC_DST="${DESTINATION}:~/$TEMP_STATIC_DIR" #SYNC_DST will evaluate to: username@webeserver:~/tmp_apache_conf  (should be a temp folder)
		
	#create temp dir at the webserver:
	ssh $DESTINATION mkdir -vp ${TEMP_STATIC_DIR} 2>&1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG} 
	
	# Perform the rsync:  (will copy the contents of conf-apache/env to the temporary folder)
	echo "*** Syncing from ${SYNC_SRC} to ${SYNC_DST} ***" | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
        
	rsync -v /dev/null "${SYNC_DST}" 2>&1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG} 
	rsync -tvr --delete --links "${SYNC_SRC}" "${SYNC_DST}" 2>&1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG} 

	echo "*** Finished rsyncing *** " | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}

	#At the webserver: Copy from the temp dir to the /var/www/vhosts/webserver01.com/conf/
	echo | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	echo "*** Copying apache conf to   ***" | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	echo | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	
	ssh $DESTINATION cp -rv ./${TEMP_STATIC_DIR}/${CONF_FILE} ${APACHE_CONF}/  2>$1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	
	#remove the temp folders from webserver
	ssh $DESTINATION rm -rf ${TEMP_STATIC_DIR} 2>$1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG} 

	echo | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	echo "*** Copying apache conf finished successfully ***" | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
done


#after the sync has been completed restart all the apache servers if requested

if [ $restart == 1 ]; then
	for WEBSERV in "$@"
	do
    	#ignore the --restart argument in this iteration
    	if [ "$WEBSERV" == "--restart" ]; then
        	continue;
    	fi
    	DESTINATION="$USER@$WEBSERV"
        ssh -t  $DESTINATION 'sudo service httpd restart' 2>&1 | sed -e "s/^/`date +'%Y-%m-%d %H:%M:%S'` /g" | tee -a ${LOG}
	done
fi




