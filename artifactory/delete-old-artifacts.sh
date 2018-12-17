#!/bin/bash

function read_default () {
	read -p "Enter $1 ($2): " VAR
	export $1=${VAR:-$2}

	varname=$1
	echo "$1 = ${!varname}"
	echo
}


# If not running from Jenkins, use a menu
if [[ "$JOB_URL" == "" ]]; then

	read_default ART_USER art_api_user 

	echo "Enter password for $ART_USER"
	read -s ART_PASS
	echo

	read_default AGE_LIMIT_RELEASE 35

	read_default DRYRUN true
fi


### Var Init ###

AGE_LIMIT_RELEASE=$(($AGE_LIMIT_RELEASE * 24 * 60 * 60))

ART_URL=_my_url_/artifactory/api

ART_REPOS="my_artifactory_repo_1"
ART_REPOS+=",my_artifactory_repo_2"

ART_NAME="my_artifact_pattern-" 


### Starting the work ###

echo "================================================================================"
echo "=== Script will search for artifafcts $ART_NAME inside the following repos: $ART_REPOS ==="
echo "================================================================================"
echo

#downloadin jq utility into bin folder
echo "=== Downloading the jg-linux64 utility ==="
rm -rf bin >/dev/null
mkdir bin

PATH=$PWD/bin/:$PATH

cd bin

wget -nv https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
if [[ $? -ne 0 ]]; then
	echo -e "\e[31mGithub failed. Exiting\e[0m"
	exit 1
else
	echo -e "\e[32m JQ utility dowloaded\e[0m"
fi

mv jq-linux64 jq
chmod +x jq

cd ..

#creating json folder

rm -rf json >/dev/null
mkdir json

for art in $ART_NAME; do

	echo "================================================================================"
	echo "=== Finding all $art artifacts ==="
	echo "================================================================================"

	# Find all artifacts matching pattern
	curl -u $ART_USER:$ART_PASS "$ART_URL/search/artifact?name=$art&repos=$ART_REPOS" > json/search.json 2>/dev/null

	num_arts=$(cat json/search.json | jq '.results | length')
	
	echo -e "\e[32mFound $num_arts artifacts, candidates for deletion\e[0m"
	echo

	echo "================================================================================"
	echo "=== Processing each artifact ==="
	echo "================================================================================"

	for (( i=0; i<$num_arts; i++ ))
	do
		echo
		echo "$(expr $i + 1) of $num_arts"

		# get the URL for this artifact's API URL
		art_url=$(cat json/search.json | jq ".results[$i].uri" | sed "s/\"//g")

		echo "Artifactory url - Candidate for deletion:"
		echo "$art_url"

		#keeping pom files for artifact reference
		if [[ $art_url == *pom ]]; then
			echo -e "\e[31mNot deleting.It's a .pom file\e[0m"
			continue
		fi
		
		curl -u $ART_USER:$ART_PASS $art_url > json/art_$i.json 2>/dev/null

		# get the date this artifact was created on. don't care about the time
		art_created=$(cat json/art_$i.json | ./bin/jq ".created" | "s/\"//g" | sed "s/T.*//")
		#art_filename=$(basename $(cat json/art_$i.json | ./bin/jq ".path" | sed "s/\"//g")) 
		art_downloaduri=$(cat json/art_$i.json | ./bin/jq ".downloadUri" | sed "s/\"//g")

		art_age=$(( $(date +"%s") - $(date --date=$art_created +"%s") ))

		if [[ $art_url == *"SNAPSHOT/"* ]]; then
			echo -e "\e[31mNot deleting. SNAPSHOT encountered\e[0m"
			continue
		fi
			
		age_limit=$AGE_LIMIT_RELEASE
		echo "Repo: $(echo $art_url | sed "s/.*storage\///" | sed "s/\/com\/.*//")"
		echo "Artifact: $(echo $art_url | sed "s/.*-local\///")"
		echo "Created: $art_created"

		if [[ $art_age -gt $age_limit ]]; then
			echo "Artifact older than $(($age_limit / 24 / 60 / 60)) days"

			# check if the artifact is tagged as live
			# for live tags or tags in general check the tag script 

			curl  -u $ART_USER:$ART_PASS -X GET $art_downloaduri?properties  > json/properties_art_$i.json 2>/dev/null

            		if grep -q "live" json/properties_art_$i.json;
			# -q, --quiet, --silent  Quiet;  do  not  write  anything  to  standard  output.   
			# Exit  immediately  with  zero  status if any match is found, even if an error was detected.  
			then
				echo -e "\e[31mNot deleting. Artifact is tagged as live.\e[0m"
				continue	
			fi

			# check if dry run is enabled
			# echo "Checking for DRYRUN"
			if [[ $DRYRUN == "true" ]];
			then
				echo -e "\e[31mNot deleting. Dry Run!\e[0m"
			else
				# Not DRYRUN option
				echo -e "\e[32mDeleting $art_downloaduri \e[0m"
				curl -X "DELETE" -u $ART_USER:$ART_PASS $art_downloaduri  > json/del_art_$i.json 2>/dev/null
			fi
		else
			echo -e "\e[31m Not deleting. Artifact younger than $(($age_limit / 24 / 60 / 60)) days\e[0m"
		fi
	done
done
