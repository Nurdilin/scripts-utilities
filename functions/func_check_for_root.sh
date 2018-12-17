##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
RESET="\033[00m"       # Normal
GREEN="\033[01;32m"    # Success


function _check_for_root {

	if [[ ${EUID} -ne 0 ]]; then
		echo -e ' '${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}. Quitting..." 1>&2
		exit 1
	else
		echo -e " ${GREEN}Continuing as root${RESET}"
	fi
}
