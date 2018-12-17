#!/bin/bash

# Script will iterate inside the cloned repos (see tha mass clone repo script)
# It will delete all remote merged branches apart of the  master and releases

for repo in $(ls -d */); do cd $repo; git branch -r --merged | grep -v "*" | grep -vi master | grep -vi release/ | sed 's/origin\///' | xargs -n 1 git push origin --delete ; cd ..; done

