#!/usr/bin/env bash

#
# Extracts the latest version of artifact-classifier-name-example
#
# source it and run in in another script
# . ./func_get_latest_build_version.sh
#
# USAGE:
# my_variable=$(_get_latest_build_version) 


function _get_latest_build_version {

	ARTIFACTORY=https://artifactory.company.com/artifactory/company-repository/
	GRP_ID=com.company.release
	ART_ID=artifact-classifier-name-example
	REPO="$ARTIFACTORY$(echo $GRP_ID/| tr '.' '/')$ART_ID"

	#echo "REPO: $REPO" #DEBUG

	LATEST_VERSION=$(curl -s $REPO"/maven-metadata.xml" | grep latest | sed "s/.*<latest>\([^<]*\)<\/latest>.*/\1/")

	#echo "Latest version from artifactory :$LATEST_VERSION" #DEBUG	
	echo $LATEST_VERSION
}	
