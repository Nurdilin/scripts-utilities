# Handle All Servers 
# Version 1
# This is avery simple script which allows mass command execution
# in all servers of an environment. The servers are hardcoded insight the script
#
# Usage examples
#
#./handleAllServers.sh "ln -sfn /home/username/release/build-newest ./current"
#./handleAllServers.sh "yum list installed | grep -e sql "
#./handleAllServers.sh "cat .bash_profile"

#!/bin/bash
ssh 02 "echo ; hostname ;$1" &&
ssh 03 "echo ; hostname ;$1" &&
ssh 04 "echo ; hostname ;$1" &&
ssh 05 "echo ; hostname ;$1" &&
ssh 06 "echo ; hostname ;$1" &&
ssh 07 "echo ; hostname ;$1" &&
ssh 08 "echo ; hostname ;$1"

