#!/bin/bash

curl --silent "https://api.github.com/users/Nurdilin/repos?per_page=20"| grep -o 'git@[^"]*'
