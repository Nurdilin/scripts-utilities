'''
    Global file holding BitBucket endpoints
'''

GET_PARAMS = {'limit' : 9999}
UPDATE_HEADER = {
    'X-Atlassian-Token': 'nocheck',
    'Content-Type': 'application/json',
}

# Authentication Endpoints
AUTH = '{server}/rest/api/latest/users/{user}'

# User Endpoints
USERS = '{server}/rest/api/latest/users/'
USER  = '{server}/rest/api/latest/users/{user}'

# Repository Endpoints
REPOS = '{server}/rest/api/latest/projects/{project}/repos'
REPO  = '{server}/rest/api/latest/projects/{project}/repos/{repo}'

# Branch Permission Endpoints
RESTRICTIONS = '{server}/rest/branch-permissions/latest/projects/{project}/repos/{repo}/restrictions'
RESTRICTION  = '{server}/rest/branch-permissions/latest/projects/{project}/repos/{repo}/restrictions/{ref}'

# Pull Requests
PULL_REQUESTS         = '{server}/rest/api/latest/projects/{project}/repos/{repo}/pull-requests'
PULL_REQUEST          = '{server}/rest/api/latest/projects/{project}/repos/{repo}/pull-requests/{ref}'
PULL_REQUEST_MERGE    = '{server}/rest/api/latest/projects/{project}/repos/{repo}/pull-requests/{ref}/merge'
PULL_REQUEST_CHANGES  = '{server}/rest/api/latest/projects/{project}/repos/{repo}/pull-requests/{ref}/changes'
PULL_REQUEST_SETTINGS = '{server}/rest/api/latest/projects/{project}/repos/{repo}/settings/pull-requests'

# Review Settings
DEFAULT_REVIEWERS     = '{server}/rest/default-reviewers/latest/projects/{project}/repos/{repo}/conditions'
DEFAULT_REVIEWER_POST = '{server}/rest/default-reviewers/latest/projects/{project}/repos/{repo}/condition'
DEFAULT_REVIEWER      = '{server}/rest/default-reviewers/latest/projects/{project}/repos/{repo}/condition/{ref}'

