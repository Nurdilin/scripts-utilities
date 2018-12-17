#!/bin/bash

# Install git on RedHat
# Find newest version in
# https://mirrors.edge.kernel.org/pub/software/scm/git/
# as root:

#install dependancies
sudo yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
sudo yum install -y gcc gcc-c++
sudo yum install autoconf automake
sudo yum install tk

#download git
sudo wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz
sudo tar xvf git-2.9.5.tar.gz
cd git-2.9.5

#installation
sudo ./configure
sudo make
sudo make install

#update git version
cd /usr/bin/
sudo rm git
sudo ln -sfn /usr/local/bin/git git

#check 
git --version
