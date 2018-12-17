#!/bin/bash
# Simple script to send a Slack notification using POST

SLACK_API_URL=https://slack.com/api

curl \
-X POST \
-H 'Authorization: Bearer xoxp-xxxxxxxxxx-xxxxxxxxxxxxx-xxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxx' \
-H 'Content-type: application/json' \
--data '{"channel":"testbot","username":"Tactical Ops","text":"Random Notification.","color":"#3AA3E3"}' \
$SLACK_API_URL/chat.postMessage


#--data '{"channel":"testbot","text":"simple text","attachments": [{"text":"Multiple choice of users, nice to have example","fallback":"You could be telling the computer exactly what it can do with a lifetime supply of chocolate.","color":"#3AA3E3","attachment_type":"default","callback_id":"select_simple_1234","actions":[{"name":"winners_list","text":"Who should win?","type":"select","data_source":"users"}]}]}' \


