#!/bin/bash

#
# This is not meant to run as standalone script.
# This was initially part of a larger script I have been using in order to automate
# a part of a deployment process via jenkins.
#
# I would connect as an ordinary user to the test environment, and then and only then I could
# escalate to a user having all the needed permissions.
# Hence the workaround.
#
# It was a pain and decided to keep it for future use as an example of a complex ssh remote command
#



###########################################################################################################
# Copying to /opt/company/release_tars and untaring
###########################################################################################################
echo -e "\033[0;32m"
echo -e "================================================================================================"
echo -e "Preparing Build at $DEPLOY_BRAND $DEPLOY_ENV under folder : /opt/release/$RELEASE_FOLDER"
echo -e "================================================================================================"
echo -e "\033[0m"


sshpass 2>/dev/null -p $SOME_PASS ssh  $SOME_USER@$SOME_IP       \
    "echo -n \"Logged in as \" ;                                 \
    whoami ;                                                     \
        sudo su - admin -c \"                                    \
                echo \\\"Running as user:  \\\" ;                \
                whoami;                                          \
                echo \\\"Create deploy dir\\\" ;                 \
                mkdir /opt/release/$RELEASE_FOLDER;              \
                echo \\\"Copy tar to release_tars\\\" ;          \
                cp /tmp/$FILENAME /opt/release_tars;             \
                echo \\\"Untaring...\\\" ;                       \
                cd /opt/release/$RELEASE_FOLDER;         \
                tar xf /opt/release_tars/$FILENAME;      \
        \";                                                      \
    echo -n \"Logged in as \" ;                                  \
    whoami ;                                                     \
    echo -n \"Remove file from /tmp directory \" ;               \
    rm /tmp/$FILENAME                                            \
    "


