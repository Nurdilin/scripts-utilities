#!/bin/bash

. ./func_get_latest_build_version.sh

function read_default () {
	read -p "$1 (default $3): " VAR
	export $2=${VAR:-$3}
}

LATEST_VERSION=$(_get_latest_build_version)
VERSION=$1

if [[ "$VERSION" == "" ]]; then
	read_default "Which version?" VERSION $LATEST_VERSION
fi

FILENAME=example-compiled-$VERSION.tgz

echo "Downloading $FILENAME"

wget https://artifactory.example.com/path/to/artifac/example-compiled/$VERSION/$FILENAME
