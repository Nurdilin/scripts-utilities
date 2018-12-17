#!/bin/bash

# 
# This script is used to set up Penetration Testing tools
# as well as some other applications in a Linux Mint 18 distribution.
# It also removes some preinstalled applications I do not find usefull.


#sudo apt-get install chromium-browser &&
sudo apt-get install terminator && 
sudo apt-get install git && 
sudo apt-get remove mono-runtime-common &&
sudo apt-get remove pidgin &&
sudo apt-get remove hexchat &&
sudo apt-get remove thunderbird &&
sudo apt-get remove gnome-orca &&
sudo apt-get install gnome-mplayer xpad &&
#download kali docker image
sudo apt-get install docker &&
sudo apt-get install docker.io &&
sudo docker pull kalilinux/kali-linux-docker &&
sudo docker pull wpscanteam/wpscan &&
#      sudo docker run --rm wpscanteam/wpscan -u http://yourblog.com
#run : sudo docker run -t -i kalilinux/kali-linux-docker /bin/bash
#inside the containier: apt-get install kali-linux-top10
sudo apt-get install w3m &&
sudo apt-get install leafpad &&
sudo apt-get install w3m &&
sudo apt-get install macchanger &&
sudo apt-get install ruby-full &&
sudo apt-get install aircrack-ng &&
sudo apt-get install apache2 &&
sudo apt-get install mingw-w64 &&
sudo apt-get install exiftool &&
sudo apt-get install guymager &&
sudo apt-get install recoverjpeg &&
sudo apt-get install hydra &&
sudo apt-get install john &&
sudo apt-get install fcrackzip && 
sudo apt-get install rarcrack &&
sudo apt-get install testdisk &&
sudo apt-get install bless &&
sudo apt-get install wireshark &&
sudo apt-get install driftnet && 
sudo apt-get install dsniff &&
sudo apt-get install dnsspoof &&
sudo apt-get install tcpkill &&
sudo apt-get install mitmproxy && 
sudo apt-get install ettercap-common && 
sudo apt-get install ferret &&
sudo apt-get install openssl &&
sudo apt-get install php &&
sudo apt-get install curl &&
sudo apt-get install elinks &&
sudo apt-get install php-xml &&
sudo apt-get install php-curl && 
#sudo apt-get install setools
sudo apt-get install wifite &&
sudo apt-get install netcat &&
#sudo apt-get install samdump2 
#sudo apt-get install bkhive 
#sudo apt-get install metasploit
sudo aptitude install libreadline5-dev libncurses5-dev && #needed for wpscan
sudo gem install bundler &&
sudo apt-get install wpscan &&
sudo apt-get install sqlmap  &&
sudo apt-get install netdiscover && 
sudo apt-get install cewl &&
#sudo apt-get install hashcat
#sudo apt-get install pwdump3
sudo apt-get install reaver &&
#sudo apt-get install bully
#sudo apt-get install hping2
sudo apt-get install hping3 &&
sudo apt-get install nodejs &&
sudo apt-get install npm &&
npm install socket.io &&
#Install Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
chmod 755 msfinstall && \
./msfinstall &&
#Install Veil Evasion
wget https://github.com/Veil-Framework/Veil-Evasion/archive/master.zip &&
unzip master.zip &&
cd Veil-Evasion-master &&
cd setup &&
( ./setup.sh || echo failed ) &&
cd ../ &&
cd ../ &&
#Install Hyperion
(( wget https://github.com/nullsecuritynet/tools/raw/master/binary/hyperion/release/Hyperion-1.2.zip &&
unzip Hyperion-1.2.zip &&
cd Hyperion-1.2 &&
i686-w64-mingw32-c++ Hyperion-1.2/Src/Crypter/*.cpp -o hyperion.exe &&
cd ../ ) || echo cannot download hyperion )&&
echo Finnished All
