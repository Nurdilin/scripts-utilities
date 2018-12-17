#!/bin/bash

JIRA_URL="https://jira.company.com"

function _read_default () {
	read -p "Enter $1 ($2): " VAR
	export $1=${VAR:-$2}

	varname=$1
	echo "$1 = ${!varname}"
	echo
}

#_read_default SJIRA_USER	username
#_read_default $JIRA_PASS	password

JIRA_USER=$1
JIRA_PASS=$2

curl -c cookie -u $JIRA_USER:$JIRA_PASS -X GET -H "Content-Type: application/json" -m 5 \
	 $JIRA_URL/rest/api/latest/status
