#!/bin/bash

# Author : Theofanis Deligiannis-Virvos
# Summary: Helper script to create bash scripts
# Usage  : ./create_script.sh scriptname (without file type)
# Tip    : create an aliases 
#          alias cs=~/scripts-utilities/utilities/create_script.sh
scriptsdir="$(dirname $0)"

_filename=$1.sh

# create file
touch $_filename

# make script executable and accessible only by user
chmod 700 $_filename

# Initialise script
echo "#!/bin/bash" > $_filename
cat "${scriptsdir}"/create_script_helper >> $_filename

# open vim on line 50
vim $_filename +50

# exit with vim's exit status
exit $?
