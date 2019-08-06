#!/bin/bash

# Examples copied from: https://wiki.bash-hackers.org/syntax/pe
# Meant to be used as notes

PARAM="this_is for test"
PARAM2="ANOTHER TEST"



echo "default  : ${PARAM}"
echo "UPPERCASE: ${PARAM^^}"
echo "Uppercase: ${PARAM^}"


echo "DEFAULT 2: ${PARAM2}"
echo "lowercase: ${PARAM2,,}"
echo "lOWERCASE: ${PARAM2,}"

FILE1="test.txt"

echo "file name  : $FILE1"
echo "name wo ext: ${FILE1%.*}" #delete minimum pattern matching  .* fromt he end
echo "file ext   : ${FILE1##*.}" #delete maximum pattern matching * .


# clean out anything that's not alphanumeric or an underscore
PARAM2=${PARAM2//[^a-zA-Z0-9_]/}
echo ${PARAM2}

#Substitute first occurrence
echo "default: ${PARAM}"
echo "substitute 1st space to _: ${PARAM/ /_}"
echo "substitute all space to _: ${PARAM// /_}"

echo "strlen: ${#PARAM}"


#Default Values"
# ${PARAMETER:-WORD}
# ${PARAMETER-WORD}

#If the parameter PARAMETER is unset (never was defined) or 
#null (empty), 
#this one expands to WORD, otherwise it expands to the value of PARAMETER, as if it just was ${PARAMETER}. 
#If you omit the : (colon), like shown in the second form, 
#the default value is only used when the parameter was unset, not when it was empty.

echo "Your home directory is: ${HOME:-/home/$USER}."
echo "${HOME:-/home/$USER} will be used to store your personal data."


read -p "Enter your gender (just press ENTER to not tell us): " GENDER
echo "Your gender is ${GENDER:-a secret}."

# Assign a default value
#${PARAMETER:=WORD}
#${PARAMETER=WORD}
#This one works like the using default values, but the default text you give is not only expanded, but also assigned to the parameter, if it was unset or null

read -p "Enter your gender (just press ENTER to not tell us): " GENDER
echo "Your gender is ${GENDER:=a secret}."
echo "Ah, in case you forgot, your gender is really: $GENDER"



