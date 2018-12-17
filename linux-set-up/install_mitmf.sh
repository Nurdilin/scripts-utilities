#!/bin/bash

##### Install mitmf
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}mitmf${RESET} ~ Man-In-The-Middle Framework"
sudo apt-get -y -qq install mitmf || echo -e ' '${RED}'[!] Issue with apt-get'${RESET}
dpkg --configure -a
