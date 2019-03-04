#!/bin/bash

J_HOME="jenkins_home"

# Current day of the year
DATE=$(date +%j)

# Stop jenkins service
echo "Stopping Jenkins..."
systemctl stop jenkins

if [ $? -eq 1 ]; then
    kill -9 $(ps -eF | grep jenkins | grep -v grep)
fi

rsync -ab -v --recursive --backup-dir=backup_$DATE --delete --filter='protect backup_*' /$J_HOME/jenkins/plugins /$J_HOME/backup/plugins/

# Re-start Jenkins instance 
echo "Starting Jenkins..."
systemctl start jenkins

if [ $? -eq 1 ]; then
    echo "Error starting jenkins"
    # TODO: notification SLACK/MAIL
fi

