#!/bin/bash

URL="https://here-be-jenkins-url.com"
JENKINS="java -jar jenkins-cli.jar -s $URL"

echo "===================== Accessing Jenkins at: $URL =====================\n"

echo "===================== Starting wget process =====================\n"
wget $URL/jnlpJars/jenkins-cli.jar
echo "===================== Jenkins-cli.jar downlodaded =====================\n"

# clear existing jobs first
echo "===================== Clearing previous back up =====================\n"
git rm -f jobs/*.xml
mkdir jobs

echo "===================== Jenkins command to be used: =====================\n"
echo $JENKINS
echo "\n"

num_jobs=$($JENKINS list-jobs | wc -l)
i=0
e=0

$JENKINS list-jobs | while read job
do
	((i++))
	echo "==== $i / $num_jobs - $job ===="

	$JENKINS get-job "$job" > "jobs/$job.xml"

	# Add failures to exit status
	((e+=$?))
done
echo "===================== Num of Jobs: $num_jobs =====================\n"

echo "===================== Removings Jenkins-cli.jar =====================\n"
rm jenkins-cli.jar

echo "===================== Commiting into stash =====================\n"
git add jobs/*.xml

#commit and push will happen via the Jenkins Job itself
#git commit --allow-empty -m "Latest Jenkins Jobs"

#git push origin master
echo "===================== Back up of jobs completed successfully =====================\n"
exit $e
