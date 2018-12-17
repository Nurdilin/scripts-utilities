#!/bin/bash
# Simple scrip to send a Slack notification for a released build

# Slack Base Configs
SLACK_API_URL=https://slack.com/api
SLACK_USERNAME="Jenkins"
SLACK_ICON="%3Ajenkins%3A"
SLACK_API_TOKEN="xoxp-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-a1b1c1d1e1f1a1ba1ca1hexhexhexmorehex"

function read_default () {
	read -p "Enter $1 ($2): " VAR
	export $1=${VAR:-$2}

	varname=$1
	echo "$1 = ${!varname}"
	echo
}
# If not running from Jenkins, use a menu
if [[ "$JOB_URL" == "" ]]; then
	# Job Specific Configs
	read_default SLACK_CHANNELS          testbot
	read_default RELEASE_VERSION         1.5880
	read_default CALLING_JOB_NAME        aggregate-release-1.5880
	read_default REPO_NAME               Aggregate
	read_default CALLING_BUILD_NUMBER    7
fi

# Build up the Attachment
SLACK_ATTACHMENT="[{"
SLACK_ATTACHMENT+="\"pretext\":    \"$REPO_NAME $RELEASE_VERSION Released\","
SLACK_ATTACHMENT+="\"fallback\":   \"$REPO_NAME $RELEASE_VERSION Released\","
SLACK_ATTACHMENT+="\"color\":      \"good\","
SLACK_ATTACHMENT+="\"title\":      \":artifactory-release: $REPO_NAME $RELEASE_VERSION\","
SLACK_ATTACHMENT+="\"title_link\": \"https://artifactory.int.company.com/artifactory/webapp/#/builds/$CALLING_JOB_NAME/$CALLING_BUILD_NUMBER\""
SLACK_ATTACHMENT+="}]"
# And urlencode it
SLACK_ATTACHMENT=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$SLACK_ATTACHMENT")

for slack_channel in $SLACK_CHANNELS; do
	# TODO: convert this to a generic script

	SLACK_API_URL_CALL="$SLACK_API_URL/chat.postMessage?"
	SLACK_API_URL_CALL+="token=$SLACK_API_TOKEN"
	SLACK_API_URL_CALL+="&channel=%23$slack_channel"
	SLACK_API_URL_CALL+="&attachments=$SLACK_ATTACHMENT"
	SLACK_API_URL_CALL+="&username=$SLACK_USERNAME"
	SLACK_API_URL_CALL+="&icon_emoji=$SLACK_ICON"

	curl "$SLACK_API_URL_CALL"

done
