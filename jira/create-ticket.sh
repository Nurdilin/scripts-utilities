#!/bin/bash

# Source this in other scripts, then call the create-ticket function
#
# First 4 parameters are mandatory, and are:
#
#	Project
#	Ticket Type
#	Summary
#	Description
#
# 5th Parameter is any additional fields you wish to set in the ticket
#
# example:
# create-ticket \
#	SAND \
#	Task \
#	"TEST TICKET" \
#	"TEST TICKET SUMMARY" \
#	",
#		\"labels\" : [\"examplelabelnumber1\", \"examplelabelnumber2\"],
#		\"fixVersions\" : [{
#			\"name\" : \"Test Release 1\"
#		}]
#	"


# Check dependencies have been set up
if [[ $JIRA_USER == "" ]]; then
	echo "create-ticket: JIRA_USER not set. Exiting"
	exit 1
fi
if [[ $JIRA_PASS == "" ]]; then
	echo "create-ticket: JIRA_PASS not set. Exiting"
	exit 1
fi

#echo $PATH
#/usr/bin/which jq
command -v jq >/dev/null 2>&1 || { echo >&2 "create-ticket: jq not set up. Exiting"; exit 1;}
#if [[ $? -ne 0 ]]; then
#	echo "create-ticket: jq not set up. Exiting"
#	exit 1
#fi

if ! [ -d json ]; then
	echo "create-ticket: No json directory, so creating one"
	mkdir json
fi

JIRA_URL="https://jira.company.com"

# Business Logic

function create-ticket() {
	# give it a random filter name
	TICKET_PROJECT="$1"
	TICKET_TYPE="$2"
	TICKET_SUMMARY="$3"
	TICKET_DESCRIPTION="$4"
	TICKET_EXTRA="$5"

	ticket_data="{
		\"fields\" : {
			\"project\" : {
				\"key\" : \"$TICKET_PROJECT\"
			},
			\"summary\" : \"$TICKET_SUMMARY\",
			\"description\" : \"$TICKET_DESCRIPTION\",
			\"issuetype\" : {
				\"name\" : \"$TICKET_TYPE\"
			}
			$TICKET_EXTRA
		}
	}"

	echo "DATA:"
	echo $ticket_data

	curl -u $JIRA_USER:$JIRA_PASS -X POST -H "Content-Type: application/json" $JIRA_URL/rest/api/latest/issue --data "$ticket_data" > json/create.json 2>/dev/null

	echo ================================================================================
	echo Result:
	echo ================================================================================

	cat json/create.json
}
