#!/bin/bash

size=$(cat ~/scripts-utilities/various/word_of_the_day/words_german.txt|wc -l)
#echo $size
rand_line=$[ $RANDOM % size ]
#echo $rand_line

awk 'NR == line {print; exit}' line=$rand_line  ~/scripts-utilities/various/word_of_the_day/words_german.txt
