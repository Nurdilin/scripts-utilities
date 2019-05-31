#! /bin/bash

#locale charmap

NO=$(python -c "print '✘'")
YES=$(python -c "print '✓'")

echo "$YES  $NO"



echo '\u2713' # not working
echo -e '\u2717' # working

printf '\u2714\u274c\n'

/usr/bin/printf "\xE2\x9C\x94 check mark\n"
#\xE2\x9C\x94 is the UTF-8 encoding of the U+2714

python -c 'print "\xE2\x9C\x94 check mark"'


YES=$(/usr/bin/printf "\xE2\x9C\x94\n")
NO=$(/usr/bin/printf "\xE2\x9C\x95\n")

echo $YES $NO


