#!/usr/bin/env bash
#example script of using an optional interactive option on automated scripts

function _interactive_mode {

	if [ "$interactive" == "1" ]; then
		read -p "$1"
	fi
}


interactive=0;

#if the option for interactive mode was used turn the interactive flag on
if [ "$1" == "--interactive" ]; then
    	interactive=1; 
fi

_interactive_mode "Press [Enter] key to run script A ..."
echo -e "Running script A \n"
./A.sh || \
{ echo "Something went wrong while running A script, stopping the process" && exit 1; }

_interactive_mode "Press [Enter] key to run script B ..."
echo -e "Running script B \n"
./B.sh || \
{ echo "Something went wrong while running B script, stopping the process" && exit 1; }



