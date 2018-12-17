'''
    Simple REST interface BitButcket
'''

from ..common.server import AtlassianServer, log_response
from .exceptions     import BitBucketConnectionError
from .resources      import Repository, User, PullRequest, PR

from .globals import (
    GET_PARAMS,
    UPDATE_HEADER,
    AUTH,
    USER,
    REPOS,
    REPO,
    RESTRICTIONS,
    RESTRICTION,
    PULL_REQUESTS,
    PULL_REQUEST_CHANGES,
    PULL_REQUEST_SETTINGS,
    DEFAULT_REVIEWERS,
    DEFAULT_REVIEWER,
    DEFAULT_REVIEWER_POST
)

import requests
import json


class BitBucketServer(AtlassianServer):
    ''' BitBucket Server object '''

    def __init__(self, auth, options):
        super(BitBucketServer, self).__init__(auth, options)


    def authenticate(self):
        ''' Authenticate the user with the BitBucket server '''

        response = requests.get(
            AUTH.format(server=self.options['server'],user=self.auth.username),
            auth=self.auth
        )

        log_response(response)
        if response.status_code == 200:
            print 'Authentication success: {o[server]}'.format(o=self.options)
        else:
            raise BitBucketConnectionError(response)


    # BitBucket request methods

    def get_user(self, user):
        ''' Returns a user object '''

        response = requests.get(
            USER.format(server=self.options['server'], user=user),
            auth=self.auth
        )

        log_response(response)
        if response.status_code == 200:
            data = json.loads(response.content)
            return User(data, self.auth)
        else:
            raise BitBucketConnectionError(response)


    def get_repo(self, project, repo):
        ''' Returns a repo object '''

        response = requests.get(
            REPO.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth
        )

        log_response(response)
        if response.status_code == 200:
            data = json.loads(response.content)
            return Repository(data, self.auth)
        else:
            raise BitBucketConnectionError(response)


    def get_repos(self, project):
        ''' Returns list of all repositories for a BitBucket project '''
        return list(self.get_repos_iter(project))


    def get_repos_iter(self, project):
        ''' Generator to get all the repositories for a BitBucket project '''

        response = requests.get(
            REPOS.format(server=self.options['server'], project=project),
            auth=self.auth,
            params=GET_PARAMS
        )

        log_response(response)
        if response.status_code == 200:
            data = json.loads(response.content)
            for value in data['values']:
                yield Repository(value, self.auth)
        else:
            raise BitBucketConnectionError(response)


    def create_repo_permission(self, project, repo, permission):
        ''' Creates all BCLC required permissions on the given repo '''

        response = requests.post(
            RESTRICTIONS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            data=json.dumps(permission.payload()),
            headers=UPDATE_HEADER
        )

        log_response(response)


    def delete_permission(self, project, repo, ref):
        ''' Deletes the given permission from the repo '''

        response = requests.delete(
            RESTRICTION.format(server=self.options['server'], project=project, repo=repo, ref=ref),
            auth=self.auth
        )
        log_response(response)


    def delete_all_repo_permissions(self, project, repo):
        ''' Finds all existing branch permissions and deletes them '''

        response = requests.get(
            RESTRICTIONS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            params=GET_PARAMS
        )

        log_response(response)
        if response.status_code == 200:
            data = json.loads(response.content)
            for value in data['values']:
                self.delete_permission(project, repo, value['id'])
        else:
            raise BitBucketConnectionError(response)


    def find_pull_request(self, project, repo, state='OPEN', direction='INCOMING', branch=None):
        ''' Finds list of pull requests in repo '''

        params = {
            'state': state,
            'direction': direction,
            'at': branch
        }

        response = requests.get(
            PULL_REQUESTS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            params=params
        )

        log_response(response)
        if response.status_code == 200:
            return [PR(p,project, repo, self.auth) for p in json.loads(response.content)['values']]
        else:
            raise BitBucketConnectionError(response)


    def get_pull_request(self, project, repo, ref):
        ''' Returns a pull request '''

        params = {
            'start': 0,
            'limit': 9999,
            'pullRequestId': ref
        }

        response = requests.get(
            PULL_REQUEST_CHANGES.format(server=self.options['server'], project=project, repo=repo, ref=ref),
            auth=self.auth,
            params=params
        )

        log_response(response)
        if response.status_code == 200:
            return PullRequest(response.url, json.loads(response.content)['values'])
        else:
            raise BitBucketConnectionError(response)


    def create_pull_request(self, project, repo, from_ref, to_ref, title, description):
        ''' Creates a pull request from_ref branch to to_ref branch '''

        payload = {
            'title': title,
            'description': description,
            'fromRef': {
                'id': from_ref,
                'repository': {
                    'slug': repo,
                    'project': {
                        'key': project
                    }
                }
            },
            'toRef': {
                'id': to_ref,
                'repository': {
                    'slug': repo,
                    'project': {
                        'key': project
                    }
                }
            },
        }

        response = requests.post(
            PULL_REQUESTS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            data=json.dumps(payload),
            headers=UPDATE_HEADER
        )

        log_response(response)


    def set_pull_request_settings(self, project, repo, approvers=1, tasks=True, builds=1, unapprove=True):
        ''' Settings management for pull requests '''

        payload = {
            'requiredApprovers': approvers,
            'requiredAllTasksComplete': tasks,
            'requiredSuccessfulBuilds': builds,
            'unapproveOnUpdate': unapprove
        }

        response = requests.post(
            PULL_REQUEST_SETTINGS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            data=json.dumps(payload),
            headers=UPDATE_HEADER
        )

        log_response(response)


    def get_default_reviewers(self, project, repo):
        ''' Get current settings for default reviewers '''

        response = requests.get(
            DEFAULT_REVIEWERS.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth
        )

        log_response(response)
        if response.status_code == 200:
            return json.loads(response.content)
        else:
            raise BitBucketConnectionError(response)


    def create_default_reviewers(self, project, repo, users=[], approvals=1):
        ''' Add a new rule for default reviewers '''

        reviewers = [{'id': u.id} for u in users]
        payload = {
            'requiredApprovals': approvals,
            'reviewers': reviewers,
            'sourceMatcher': {
                'id': 'any',
                'type': {
                    'id': 'ANY_REF'
                }
            },
            'targetMatcher': {
                'id': 'any',
                'type': {
                    'id': 'ANY_REF'
                }
            }
        }

        response = requests.post(
            DEFAULT_REVIEWER_POST.format(server=self.options['server'], project=project, repo=repo),
            auth=self.auth,
            data=json.dumps(payload),
            headers=UPDATE_HEADER
        )

        log_response(response)
        if response.status_code != 200:
            print response.content


    def update_default_reviewers(self, project, repo, ref, users=[], approvals=1):
        ''' Update a default reviewer rule '''

        reviewers = [{'id': u.id} for u in users]
        payload = {
            'requiredApprovals': approvals,
            'reviewers': reviewers,
            'sourceMatcher': {
                'id': 'any',
                'type': {
                    'id': 'ANY_REF'
                }
            },
            'targetMatcher': {
                'id': 'RELEASE',
                'type': {
                    'id': 'MODEL_CATEGORY'
                }
            }
        }

        response = requests.put(
            DEFAULT_REVIEWER.format(server=self.options['server'], project=project, repo=repo, ref=ref),
            auth=self.auth,
            data=json.dumps(payload),
            headers=UPDATE_HEADER
        )

        log_response(response)
        if response.status_code != 200:
            print response.content


    def delete_default_reviewers(self, project, repo, ref):
        ''' Delete a default reviewer rule '''

        response = requests.delete(
            DEFAULT_REVIEWER.format(server=self.options['server'], project=project, repo=repo, ref=ref),
            auth=self.auth,
            headers=UPDATE_HEADER
        )

        log_response(response)
        if response.status_code != 200:
            print response.content
