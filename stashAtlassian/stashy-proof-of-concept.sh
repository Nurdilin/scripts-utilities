#!/usr/bin/python


#
# A simple script to demonstrate usage of 
# stashy
# os
# json
# It s used to clone all repos of a Project among  various prints for demonstration puproses
#

import sys
import os
import getpass
import stashy
import json

usr = getpass.getuser()
pwd = getpass.getpass("Enter Stash password for %s: " % usr)

stash = stashy.connect("http://example.com", usr, pwd)


print "Projects in Stash"
for i in stash.projects.list():
        #{u'name': u'MY_PROJECT', u'links': {u'self': [{u'href': u'https://example.com/projects/MY_PROJECT'}]}, u'id': 197, u'key': u'WCL', u'type': u'NORMAL', u'public': False}

	print "name: " + i["name"]
	print "id: " + str(i["id"]) + "\n"
	#print(i["links"])	#another way of running print

print "Repos in Project MY_PROJECT"
for j in stash.projects["MY_PROJECT"].repos.list():
	print j["name"]


for repo in stash.projects["MY_PROJECT"].repos.list():
	print repo
	# print will print the following
	#{u'scmId': u'git', u'forkable': False, u'name': u'example-repo', u'links': {u'clone': [{u'href': u'ssh://git@example.com:7999/my_project/example-repo.git', u'name': u'ssh'}, {u'href': u'https://username@example.com/scm/my_project/example-repo.git', u'name': u'http'}], u'self': [{u'href': u'https://example.com/projects/MY_PROJECT/repos/example-repo/browse'}]}, u'id': 6051, u'project': {u'description': u'This is the example repository for the MY_PROJECT project', u'links': {u'self': [{u'href': u'https://example.com/projects/MY_PROJECT'}]}, u'id': 3973, u'key': u'MY_PROJECT', u'type': u'NORMAL', u'public': False, u'name': u'Example'}, u'public': False, u'state': u'AVAILABLE', u'slug': u'example-repo', u'statusMessage': u'Available'}

	r = json.dumps(repo)
	print r
	#print now will not contain the u unicode encoding identifier
	#{"scmId": "git", "forkable": false, "name": "example-repo", "links": {"clone": [{"href": "ssh://git@example.com:7999/my_project/example-repo.git", "name": "ssh"}, {"href": "https://username@example.com/scm/my_project/example-repo.git", "name": "http"}], "self": [{"href": "https://example.com/projects/MY_PROJECT/repos/example-repo/browse"}]}, "id": 6051, "project": {"description": "This is the example repository for the MY_PROJECT project", "links": {"self": [{"href": "https://example.com/projects/MY_PROJECT"}]}, "id": 3973, "key": "MY_PROJECT", "type": "NORMAL", "public": false, "name": "Example"}, "public": false, "state": "AVAILABLE", "slug": "example-repo", "statusMessage": "Available"}
	print "\n"

	print json.dumps(repo, indent=4)
	######### print will prin in a tree like structure ####################################################################
	#
	#{
	#	"scmId": "git",
	#	"forkable": false,
	#	"name": "example-repo",
	#	"links": {
	#		"clone": [
	#			{
	#				"href": "ssh://git@example.com:7999/my_project/example-repo.git",
	#				"name": "ssh"
	#			},
	#			{
	#				"href": "https://username@example.com/scm/my_project/example-repo.git",
	#				"name": "http"
	#			}
	#		],
	#		"self": [
	#			{
	#				"href": "https://example.com/projects/MY_PROJECT/repos/example-repo/browse"
	#			}
	#		]
	#	},
	#	"id": 6051,
	#	"project": {
	#		"description": "This is the example repository for the MY_PROJECT project",
	#		"links": {
	#			"self": [
	#				{
	#					"href": "https://example.com/projects/MY_PROJECT"
	#				}
	#			]
	#		},
	#		"id": 3973,
	#		"key": "MY_PROJECT",
	#		"type": "NORMAL",
	#		"public": false,
	#		"name": "Example"
	#	},
	#	"public": false,
	#	"state": "AVAILABLE",
	#	"slug": "example-repo",
	#	"statusMessage": "Available"
	#}
	#################################################################################################################################	

	#Clone all repos of project
	for url in repo["links"]["clone"]:
		if (url["name"] == "ssh"):
			os.system("git clone %s" % url["href"])


