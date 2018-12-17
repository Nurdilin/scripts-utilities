#!/bin/bash
#
#
TAG_NAME=live.build
 
if [ $TAG_NAME == 'live.build' ]; then
	# Remove all the live.build tags as we need only the latest one
	./tag-artifact.sh -X DELETE -P $TAG_NAME
fi
./tag-artifact.sh -V "$TAG_VERSION" -P $TAG_NAME -v true
