#!/bin/bash
# Simple script to create a new Slack channel and invite people 

# run:
# ./create-release-channel.sh

SLACK_API_URL=https://slack.com/api
CHANNEL=$1

# Create a new channel
# Note: "'$CHANNEL'"

curl \
-X POST \
-H 'Authorization: Bearer xoxp-xxxxxxxxxx' \
-H 'Content-type: application/json' \
--data '{"name":"'$CHANNEL'"}' \
$SLACK_API_URL/conversations.create

# Invite users

curl \
-X POST \
-H 'Authorization: Bearer xoxp-xxxxxxxxxx' \
-H 'Content-type: application/json' \
--data '{"channel":"'$CHANNEL'","users":"user1,user2,user3"}' \
$SLACK_API_URL/conversations.invite

# Set purpose

curl \
-X POST \
-H 'Authorization: Bearer xoxp-xxxxxxxxxx' \
-H 'Content-type: application/json' \
--data '{"channel":"'$CHANNEL'","purpose":"Release Engineers coordination"}' \
$SLACK_API_URL/conversations.setPurpose
