#!/bin/bash
#=======================================================
# Wrapper around artifactory-set-property mojo
#=======================================================

groupId=""
artifactId=""
version=""
propertyValue="true"
pluginVersion="LATEST"

set -e
while getopts :a:g:P:p:v:V: opt
do
	case $opt in
		a)  artifactId=$OPTARG;;
		g)  groupId=$OPTARG;;
		P)  propertyName=$OPTARG;;
		v)  propertyValue=$OPTARG;;
		V)  version=$OPTARG;;
		p)  pluginVersion=$OPTARG;;
		h)  USAGE=1;;
		\?) USAGE=1;;
	esac
done

shift $((OPTIND -1))

if [[ $USAGE -eq 1 ]] ; then
	cat << __END__
usage: $0 options args...
	where options can be any of the following
		-g groupId       - (com.company.backoffice)
		-a artifactId    - (company-office)
		-V version       - (8.1.5.0)
		-P propertyName  - Property property
		-v propertyValue - ($propertyValue) Property Value
		-p pluginVersion - ($pluginVersion) Plugin version
		-h help          - produce this message (optional)
__END__
	exit 2
fi

#if the file name already exist prepare a backup version
if [ -f company-pom.pom ]
	then
		mv company-pom.pom company-pom.pom.bk
fi

# download latest released parent pom
mvn -U org.apache.maven.plugins:maven-dependency-plugin:RELEASE:copy \
	-Dartifact=com.company:company-pom:RELEASE:pom \
	-Dmdep.stripVersion=true \
	-DoutputDirectory=. \
	-Dmdep.useBaseVersion=true

# Call the plugin's artifactory-set-property mojo
mvn -U \
	-Dproject.basedir=. \
	-DoutputDirectory=target \
	com.company.plugin:company-maven-plugin:${pluginVersion}:artifactory-set-property \
	--file="company-pom.pom" \
	-DgroupId=$groupId \
	-DartifactId=$artifactId \
	-Dversion=$version \
	-DpropertyName=$propertyName \
	-DpropertyValue=$propertyValue \
	-Dartifactory.api.user=$ARTIFACTORY_API_USER \
	-Dartifactory.api.password=$ARTIFACTORY_API_PASSWORD


#remove the new parent pom
if [ -f company-pom.pom.bk ]
	then
		#restore bk
		mv company-pom.pom.bk company-pom.pom
	else
		rm company-pom.pom
fi

