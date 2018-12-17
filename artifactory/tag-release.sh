#!/bin/bash
#=======================================================
# Wrapper around artifactory-set-property mojo
#=======================================================

version=""
propertyValue=""
action="PUT"
groupId="com.company-company.release"
artifactId="company-release-sources"
group_id=""

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
	cat << __END__
usage: $0 options args...
i   where options can be any of the following
    -V version       - (8.1.5.0)
    -P propertyName  - Property property
    -g groupId       - (com.company-company.release)
    -a artifactId    - (company-release-sources)
    -v propertyValue - ($propertyValue) Property Value
    -X action        - (PUT/GET/DELETE). Default is PUT.
    -h help          - produce this message (optional)
__END__
	exit 2
fi

group_id=`echo $groupId | sed -e 's/\./\//g'`
if [ -n "$propertyValue" ]; then 
    propertyValue="=$propertyValue"
fi

curl -kv -u $ARTIFACTORY_API_USER:$ARTIFACTORY_API_PASSWORD -X $action https://artifactory.int.company.com/artifactory/api/storage/company-release-local/$group_id/$artifactId/$version?properties=$propertyName$propertyValue 
