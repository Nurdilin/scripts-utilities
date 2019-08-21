#!/bin/bash

# Author : Theofanis Deligiannis-Virvos
# Summary: Helper script to create bash scripts
# Usage  : ./create_script.sh scriptname (without file type)
# Tip    : create an aliases 
#          alias cs=~/scripts-utilities/utilities/create_script.sh


if [[ "$#" -eq 0 ]]; then
	echo "Usage: $(basename $0) file_name"
	exit 1
fi

_filename=$1.sh

# create file
touch $_filename

# make script executable and accessible only by user
chmod 700 $_filename

# Initialise script
echo "#!/bin/bash" > $_filename
echo "# Author : Theofanis Deligiannis-Virvos" >> $_filename
echo "# Summary:" >> $_filename
echo "# Usage  :" >> $_filename
echo "" >> $_filename

# open vim on line 5
vim $_filename +5

# exit with vim's exit status
exit $? 
