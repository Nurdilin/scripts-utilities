#!/usr/bin/env python3

# INVASIVE approach! BE CAREFUL! I do not assume any responsibility for deleted branches by accident.

# Example script and various comments for future reference
# Cleans only one repo, but it can easily be altered to handle all repos
# Check also: https://python-gitlab.readthedocs.io/en/stable/gl_objects/branches.html

import gitlab #install python-gitlab and not plain gitlab
import os
from os import environ

def cleanMergedBranches(project):	
	print("Starting cleaning up merged branches\n")
	#Get the list of branches for a repository:
	branches = project.branches.list()
	for branch in branches:
		#print(branch) 
		#print(branch.name)
		#print(branch.merged)
		if (branch.merged) is True:
			print("Branch " + branch.name + " is merged. Proceeding with deleting it")
			#branch.delete() #commenting this out because there are people out there who blindly copy and run scripts from the internet
			print("Branch deleted")
		else:
			print("Branch " + branch.name + " is not merged. We will not delete it")
		
	#branch = project.branches.get('master')
		
	#Delete the merged branches for a project:
	#project.delete_merged_branches()
	
	#project.branches.delete('feature1')
	#or
	#branch.delete()
	
	#Create a repository branch:
	#branch = project.branches.create({'branch': 'feature1', 'ref': 'master'})
	
	return 0	

debug = 0
if debug is 0 :
	gitlab_server_url="https://company.com"
	gitlab_project="company/repo"
	#gitlab_token #production token that comes from Jenkins' password plugin
else :
	######## for test ###############
	gitlab_server_url='https://company-testing.com'
	gitlab_project='deligiannis/test'
	gitlab_token="XXXXXXXXXXXX_XXX"
	
'''if environ.get('gitlab_token') is not None:
	gitlab_token=os.environ['gitlab_token']
else:
	print("Error : No gitlab_token environment variable found, it's an issue. Stop")
	exit(1)

if environ.get('gitlab_server_url') is not None:
	gitlab_server_url=os.environ['gitlab_server_url']
else:
	print("Error : No gitlab_server_url environment variable found, it's an issue. Stop")
	exit(1)

if environ.get('gitlab_project') is not None:
	gitlab_project=os.environ['gitlab_project']
else:
	print("Error : No gitlab_project environment variable found, it's an issue. Stop")
	exit(1)
'''

print("gitlab_server_url:"+str(gitlab_server_url))
print("gitlab_project:"+str(gitlab_project) + "\n")

# private token or personal token authentication / connection to gitlab
gl = gitlab.Gitlab(gitlab_server_url, private_token=gitlab_token)
if gl is None:
	print("Error: issue during connection to gitlab server :"+gitlab_server_url+ ".")
	exit(1)

# list all the projects
projects = gl.projects.list()
print("List of Projects")
for project in projects:
	#print(project) #returns whole object
	print(project.name)

#get the project
project = gl.projects.get(gitlab_project)
if project is None:
	print("Error: issue while getting gitlab project: "+gitlab_project+" from gitlab server :"+gitlab_server_url+ ".")
	exit(1)

print("\nWe will clean up project: " + str(project.name))

cleanMergedBranches(project)

exit(0)
