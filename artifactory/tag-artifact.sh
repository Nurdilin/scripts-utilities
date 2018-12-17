#!/bin/bash

version=""
propertyValue=""
action="PUT"
groupId=""
artifactId=""
group_id=""
ARTIFACTORY_API_USER=""
ARTIFACTORY_API_PASSWORD=""

set -e
while getopts :a:g:P:v:V:X: opt
do
	case $opt in
		P)  propertyName=$OPTARG;;
		a)  artifactId=$OPTARG;;
		v)  propertyValue=$OPTARG;;
		g)  groupId=$OPTARG;;
		X)  action=$OPTARG;;
		V)  version=$OPTARG;;
		h)  USAGE=1;;
		\?) USAGE=1;;
	esac
done

shift $((OPTIND -1))

if [[ $USAGE -eq 1 ]] ; then
	cat << _END_
usage: $0 options args...
	where options can be any of the following
		-V version       - (8.1.5.0)
		-P propertyName  - Property property
		-g groupId       - (com.company.release)
		-a artifactId    - (release-sources)
		-v propertyValue - ($propertyValue) Property Value
		-X action        - (PUT/GET/DELETE). Default is PUT.
		-h help          - produce this message (optional)
_END_
	exit 2
fi

group_id=$(echo $groupId | sed -e 's/\./\//g')
if [ -n "$propertyValue" ]; then 
    propertyValue="=$propertyValue"
fi

#From Artifactory's Documentation
#The example below demonstrates how to invoke the Deploy Artifact REST API.
#	You are using cURL from the unix command line, and are presently working from the home (~) directory of the user 'myUser'
#	You wish to deploy the file 'myNewFile.txt', which is located in your Desktop directory, ('~/Desktop/myNewFile.txt')
#	You have Artifactory running on your local system, on port 8081
#	You wish to deploy the artifact into the 'my-repository' repository, under the 'my/new/artifact/directory/' folder structure, 
#	and wish to store the file there as 'file.txt'
#	You have configured a user in Artifactory named 'myUser', with password 'myP455w0rd!', and this user has permissions to deploy artifacts
#	Your API Key is 'ABcdEF'
#	Using cURL with the REST API
#
#curl -u myUser:myP455w0rd! -X PUT "http://localhost:8081/artifactory/my-repository/my/new/artifact/directory/file.txt" -T Desktop/myNewFile.txt
#curl -u myUser:ABcdEF -X PUT "http://localhost:8081/artifactory/my-repository/my/new/artifact/directory/file.txt" -T Desktop/myNewFile.txt


curl -kv -u $ARTIFACTORY_API_USER:$ARTIFACTORY_API_PASSWORD -X $action https://artifactory.int.company.com/artifactory/api/storage/company-release-local/$group_id/$artifactId/$version?properties=$propertyName$propertyValue 





