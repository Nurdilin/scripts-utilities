#!/bin/bash

while [[ $# > 1 ]]; do
	key="$1"

	case $key in
		-e|--extension)
		EXTENSION="$2"
		shift
		;;

		-s|--searchpath)
		SEARCHPATH="$2"
		shift
		;;

		-l|--lib)
		LIBPATH="$2"
		shift
		;;

		--default)
		DEFAULT=YES
		shift
		;;

		*)
		    # unknown option
		;;
	esac
	shift
done

echo FILE EXTENSION  = "${EXTENSION}"
echo SEARCH PATH     = "${SEARCHPATH}"
echo LIBRARY PATH    = "${LIBPATH}"

echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi
