#!/bin/bash

SOURCE_DIR=""
DEST_DIR=""
TEMP_DIR=""

DEST_HOST=""

function _show_usage () {
cat << EOF
Usage: sync_rp.sh -s <source dir> -d <destination dir> -h "<destination hosts>"
  -s directory to copy the files from 
  -d directory to copy the files to 
  -h a space separated list of hostnames to copy the RP XML files to. Mandatory.
EOF
}

while getopts d:h:s: o
do
	case $o in
		s) SOURCE_DIR=$OPTARG;;
		d) DEST_DIR=$OPTARG;;
		h) DEST_HOST=$OPTARG;;
	esac
done

if [[ -z "${DEST_HOST}" ]]; then
	echo "ERROR: Please supply a destination host"
	_show_usage
	exit 1
fi

if [[ -z "${SOURCE_DIR}" ]]; then
	echo "ERROR: Please supply a source folder"
	_show_usage
	exit 1
fi

if [[ -z "${DEST_DIR}" ]]; then
	echo "ERROR: Please supply a destination folder"
	_show_usage
	exit 1
fi


TEMP_DIR=$(mktemp -d)

# Now normalise the directories to make sure they dont have any trailing slashes
SOURCE_DIR=$(readlink -f "${SOURCE_DIR}")

# Rsync from SOURCE_DIR into TEMP_DIR. We then delete the source files from SOURCE_DIR so we dont duplicate them in the future
rsync -av --remove-source-files "${SOURCE_DIR}/" "${TEMP_DIR}"


for host in $DEST_HOST
do
	echo ""
	echo "Copying the files to ${host}:${DEST_DIR}"
	echo ""
	rsync -av "${TEMP_DIR}/" "${host}:${DEST_DIR}"
done

rm -rf ${TEMP_DIR}

