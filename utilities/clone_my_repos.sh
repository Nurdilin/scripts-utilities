#!/bin/bash
GIT_USER=Nurdilin

for repo in $(curl --silent "https://api.github.com/users/$GIT_USER/repos?per_page=20"| grep -o 'git@[^"]*'); do
	echo $repo;
	git clone $repo && echo -e "$repo Downloaded\n"
done

