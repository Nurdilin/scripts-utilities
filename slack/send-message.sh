#!/bin/bash
# Simple script to send a Slack notification

# Slack Base Configs

SLACK_API_URL=https://slack.com/api
SLACK_API_TOKEN="xoxp-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-a1b1c1d1e1f1a1ba1ca1hexhexhexmorehex"
#SLACK_USERNAME="Deployment%20Notification"
SLACK_USERNAME="Dev%20Ops%20Spammer"
#SLACK_ICON="https%3A%2F%2Favatars.slack-edge.com%2F2016-01-29%2F19791142289_dbad61227bce3d14bc39_48.jpg"
#SLACK_ICON="https%3A%2F%2Fca.slack-edge.com%2FT02TJGFUQ_U7F7VEQ91_625bdebc5cf4_48.jpg"
SLACK_ICON="%3Ajenkins%3A"

function _read_default () {
	read -p "Enter $1 ($2): " VAR
	export $1=${VAR:-$2}

	varname=$1
	echo "$1 = ${!varname}"
	echo
}

# Job Specific Configs
_read_default SLACK_CHANNELS		testbot
_read_default TEXT			<!here|here>your%20call%20is%20important%20to%20us!Please%20try%20again%20later

MESSAGE=$(echo $TEXT | sed 's/ /%20/g') #translate space characters to url friendly %20


for slack_channel in $SLACK_CHANNELS; do

	SLACK_API_URL_CALL="$SLACK_API_URL/chat.postMessage?"
	SLACK_API_URL_CALL+="token=$SLACK_API_TOKEN"
	SLACK_API_URL_CALL+="&channel=$slack_channel"
	SLACK_API_URL_CALL+="&username=$SLACK_USERNAME"
	SLACK_API_URL_CALL+="&icon_emoji=$SLACK_ICON"
	SLACK_API_URL_CALL+="&text=$MESSAGE"

	echo "Calling $SLACK_API_URL_CALL"
	curl "$SLACK_API_URL_CALL"
done
