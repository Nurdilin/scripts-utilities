#!/bin/bash

# Extracts the version number from a Maven pom file, for use in other scripts
# Parameters:
#	$1 - filename


# Assumes that the first instance of <version> is the repository's version.
# This will return the incorrect answer if this assumption does not hold.

cat $1 | \
grep "<version>" |\
head -n 1 |\
sed "s/<\/*version>//g" |\
sed "s/ //g" |\
sed "s/\t//g"
