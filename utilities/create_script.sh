#!/bin/bash

# Author : Theofanis Deligiannis-Virvos
# Summary: Helper script to create bash scripts
# Usage  : ./create_script.sh scriptname (without file type)
# Tip    : create an aliases 
#          alias cs=~/scripts-utilities/utilities/create_script.sh

# create file
touch $1.sh

# make script executable and accessible only by user
chmod 700 $1

# Initialise script
echo "#!/bin/bash" > $1
echo "# Author : Theofanis Deligiannis-Virvos" >> $1
echo "# Summary:" >> $1
echo "# Usage  :" >> $1

# open vim on line 5
vim $1 +5

# exit with vim's exit status
exit $? 
