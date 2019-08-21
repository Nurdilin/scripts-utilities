#!/bin/bash
# Author : Theofanis Deligiannis-Virvos
# Summary:
# Usage  :


if [[ "$#" -eq 0 ]]; then
	echo "Usage: $(basename $0) title"
	exit 1
fi

echo -e "\033]0;$@\007"

exit 0
