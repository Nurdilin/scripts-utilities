#!/bin/bash

#From inside the cloned repo:
# It will delete all remote merged branches apart of the  master and releases

git branch -r --merged | grep -v "*" | grep -v master | grep -v release/ | sed 's/origin\///' | xargs -n 1 git push origin --delete 
