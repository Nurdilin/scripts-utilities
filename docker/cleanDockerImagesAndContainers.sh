#!/bin/bash
#-e to interpret backslashed characters
echo -e "Before Removing\n\n\n"
echo -e "====> Containers\n"
sudo docker ps -a
echo -e "\n\n\n\n"

echo -e "====> Images\n"
sudo docker images
echo -e "\n\n\n\n"
echo -e "====> Deleting...\n"
#this will delete all containers
sudo docker rm -v $(sudo docker ps -a -q -f status=exited)

#this will delete the images
sudo docker rmi $(sudo docker images -q)
echo -e "\n\n\n"

echo -e "After Removing\n\n\n\n"
echo -e "====> Containers\n"
sudo docker ps -a

echo -e "====> Images\n"
sudo docker images

