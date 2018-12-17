#!/bin/bash
IP=$(ifconfig | grep -E 'inet ' | grep -v '127.\|196.\|10.' |awk '{ print $2}'|sed 's/addr://')
echo $IP
notify-send  IP $IP
