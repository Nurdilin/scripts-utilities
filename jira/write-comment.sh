#!/bin/bash

function _read_default () {
	read -p "Enter $1 ($2): " VAR
	export $1=${VAR:-$2}

	varname=$1
	echo "$1 = ${!varname}"
	echo
}

JIRA_URL="https://jira.company.com"

# If not running from Jenkins, use a menu
if [[ "$JOB_URL" == "" ]]; then
	_read_default JIRA_USER    username
	_read_default JIRA_TICKET  LC-88
	_read_default JIRA_COMMENT "Test Jira Comment"

	echo "Enter password for $JIRA_USER"
	read -s JIRA_PASS
	echo

fi


curl -c cookie -u $JIRA_USER:$JIRA_PASS -X POST -H "Content-Type: application/json" $JIRA_URL/rest/api/latest/issue/$JIRA_TICKET/comment --data "{\"body\":\"$JIRA_COMMENT\"}"
