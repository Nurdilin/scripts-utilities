#!/bin/bash

# Extracts the artifactId from a Maven pom file, for use in other scripts
# Parameters:
#	$1 - filename


# Assumes that the first instance of <artifactId> is the repository's artifact id.
# This will return the incorrect answer if this assumption does not hold.

cat $1 | \
grep "<artifactId>" |\
head -n 1 |\
sed "s/<\/*artifactId>//g" |\
sed "s/ //g" |\
sed "s/\t//g"
