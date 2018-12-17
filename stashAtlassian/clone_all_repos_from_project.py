#!/usr/bin/python

# This script will clone all of the repos in the "PROJECT" Stash project into the current directory.

#
# To install dependency `pip install stashy`
# If you see an error about egg_info, try running `pip install --upgrade setuptools`
# The script will still work even if you see a huge warning about SSL being misconfigured.
#

import sys
import os
import getpass
import stashy

#https://docs.python.org/2/library/getpass.html

usr = getpass.getuser() #Return the “login name” of the user.
pwd = getpass.getpass("Enter Stash password for %s: " % user)

stash = stashy.connect("http://stash.example.com", user, pwd)

for repo in stash.projects["PROJECT"].repos.list():
    if "Deprecated" in repo["name"] or "Abandoned" in repo["name"]:
        continue
    for url in repo["links"]["clone"]:
        if (url["name"] == "ssh"):
            os.system("git clone %s" % url["href"])
            break
