#!/bin/bash

echo -e "Before Removing\n\n\n"
echo -e "====> Containers\n"
sudo docker ps -a
echo -e "\n\n\n\n"
echo -e "====> Deleting...\n"
#this will delete all containers
sudo docker rm -v $(sudo docker ps -a -q -f status=exited)
echo -e "\n\n\n"
echo -e "After Removing\n\n\n\n"
echo -e "====> Containers\n"
sudo docker ps -a
