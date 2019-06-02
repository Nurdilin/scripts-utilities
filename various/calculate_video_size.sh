#!/bin/bash


# cd to folder with videos
# assumung mkv format
# TODO format as an argument
# TODO convert time to hours and minutes 

# paste -s   : Paste on same line with tabs         : 134 tab 564 tab
# paste -sd+ : Paste on same line with delimeter +  : 134+564


for video in *.mkv ; do ffprobe -v quiet -of csv=p=0 -show_entries format=duration $video; done |paste -sd+ | bc
