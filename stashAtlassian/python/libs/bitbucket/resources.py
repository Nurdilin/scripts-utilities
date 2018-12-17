'''
    Resource objects for BitBucket
'''

from ..common.server import log_response
from .exceptions     import BitBucketConnectionError
from .globals        import PULL_REQUEST_MERGE, UPDATE_HEADER
from enum            import Enum

import requests
import json
import os

class User(object):
    ''' Simplified BitBucket Repository object '''

    def __init__(self, user, auth):

        self.user = user
        self.auth = auth

        self.id   = user['id']
        self.slug = user['slug']
        self.name = user['name']
        self.mail = user['emailAddress']


class Permission(object):
    ''' Permission object '''

    class Restriction(Enum):
        ''' Restrictions allowed '''
        DELETION     = 'no-deletes'
        PULL_REQUEST = 'pull-request-only'
        HISTORY      = 'fast-forward-only'

    class Matcher(Enum):
        ''' Match Types allowed '''
        PATTERN      = 'Pattern'
        MODEL_BRANCH = 'Branch model branch'

    def __init__(self, restriction, matcher, value, users=[]):
        self.restriction = self.Restriction
        self.restriction = restriction
        self.matcher     = matcher
        self.value       = value
        self.users       = [u.slug for u in users]

    def payload(self):
        ''' Return permission formatted payload '''
        return {
            'type' : self.restriction.value,
            'matcher' : {
                'id': self.value,
                'displayId': self.value.title(),
                'type': {
                    'id': self.matcher.name,
                    'name': self.matcher.value
                },
                'active': True
            },
            'users' : self.users
        }


class Repository(object):
    ''' Simplified BitBucket Repository object '''

    def __init__(self, repo, auth):

        self.repo = repo
        self.auth = auth

        self.slug  = repo['slug']
        self.name  = repo['name']
        self.links = self.Links(repo['links'])


    def is_file(self, path, branch=None):
        ''' Check if file exists in repo '''

        response = requests.get(
            '/'.join([self.links.self.rest, 'browse', path]),
            auth=self.auth,
            params={'type': True, 'at': branch}
        )
        log_response(response)
        if response.status_code == 200:
            return json.loads(response.content)['type'] == 'FILE'
        return False


    def is_dir(self, path, branch=None):
        ''' Check if directory exists in repo '''

        response = requests.get(
            '/'.join([self.links.self.rest, 'browse', path]),
            auth=self.auth,
            params={'type': True, 'at': branch}
        )
        log_response(response)
        if response.status_code == 200:
            return json.loads(response.content)['type'] == 'DIRECTORY'
        return False


    def get_file(self, path, branch=None):
        ''' Returns the contents of a raw file from Stash '''

        response = requests.get(
            '/'.join([self.links.self.browse, path]),
            auth=self.auth,
            params={'raw':'', 'at': branch}
        )
        log_response(response)
        if response.status_code == 200:
            return response.content.strip()
        else:
            raise BitBucketConnectionError(response)


    # Nested classes
    class Links(object):
        ''' Links object '''
        class Clone(object):
            ''' Clone object '''
            def __init__(self, links):
                self.ssh  = [x['href'] for x in links if x['name'] == 'ssh'][0]
                self.http = [x['href'] for x in links if x['name'] == 'http'][0]
        class Self(object):
            ''' Self object '''
            def __init__(self, links):
                self.browse = links[0]['href']
                self.rest   = os.path.dirname('rest/api/latest/project'.join(self.browse.split('project')))

        def __init__(self, links):
            self.clone = self.Clone(links['clone'])
            self.self  = self.Self(links['self'])

# TODO Change to PullRequest
class PR(object):
    ''' Class object representing PR description '''
    def __init__(self, pull, project, repo, auth):
        self.auth        = auth
        self.id          = pull['id']
        self.version     = pull['version']
        self.title       = pull['title']
        self.description = pull['description']
        self.from_ref    = pull['fromRef']['id']
        self.to_ref      = pull['toRef']['id']
        self.project     = project
        self.repo        = repo
        self.server      = pull['links']['self'][0]['href'].split('/projects')[0]

    def merge(self):
        ''' Attempt to Merge the pull request '''
        response = requests.post(
            PULL_REQUEST_MERGE.format(server=self.server, project=self.project, repo=self.repo, ref=self.id),
            params={'version': self.version},
            auth=self.auth,
            headers=UPDATE_HEADER
        )
        log_response(response)
        if response.status_code != 200:
            raise BitBucketConnectionError(response)

    def __repr__(self):
        return '<libs.bitbucket.resources.PR:{s.project}/{s.repo}/{s.id}:{s.from_ref}->{s.to_ref}>'.format(s=self)

# TODO Change to PullRequestDetail
class PullRequest(object):
    ''' Class object representing a pull request '''
    def __init__(self, url, files):
        self.url     = url
        self.project = url.split('projects/')[1].split('/')[0]
        self.repo    = url.split('repos/')[1].split('/')[0]
        self.id      = url.split('pull-requests/')[1].split('/')[0]
        self.files   = [f['path']['toString'] for f in files]
