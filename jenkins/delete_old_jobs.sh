#!/bin/bash

#
# Deletes jobs from VIEW old_jobs
# View was setup to gather incactive jobs

wget https://jenkins-url.com/jnlpJars/jenkins-cli.jar

#java -jar jenkins-cli.jar -s https://jenkins-url.com/ create-view < ./old_jobs_view.xml

echo "deleting the following jobs\n"
for job in $(java -jar jenkins-cli.jar -s  https://jenkins-url.com/ list-jobs old_jobs); do echo $job ; done

#for job in $(java -jar jenkins-cli.jar -s  https://jenkins-url.com/ list-jobs old_jobs); do echo $job >> to_delete.txt ; done
#for job in $(cat ./to_delete.txt); do echo $job; java -jar jenkins-cli.jar -s https://jenkins-url.com/ delete-job $job  ; done

for job in $(java -jar jenkins-cli.jar -s  https://jenkins-url.com/ list-jobs old_jobs); do echo "deleting job $job"; java -jar jenkins-cli.jar -s https://jenkins-url.com/ delete-job $job ; done

#rm ./to_delete.txt
rm ./jenkins-cli.jar
