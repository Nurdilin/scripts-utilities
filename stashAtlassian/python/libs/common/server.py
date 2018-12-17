'''
    Simple REST interface for Jira
'''

import base64
import requests

class AtlassianServer(object):
    ''' Server object '''

    @classmethod
    def by_credentials(cls, username, password, options):
        ''' Initialise by username password '''
        auth = requests.auth.HTTPBasicAuth(username, password)
        return cls(auth, options=options)

    @classmethod
    def by_token(cls, token, options):
        ''' Initialise by base64 token '''
        auth = requests.auth.HTTPBasicAuth(*base64.b64decode(token).split(':'))
        return cls(auth, options=options)

    def __init__(self, auth, options):
        self.options = options
        self.auth    = auth
        self.cookies = self.authenticate()

    def authenticate(self):
        ''' Placeholder for the authentication method '''
        raise Exception('Cannot connect to {o[server]}: authenticate method unimplemented'.format(o=self.options))


def log_response(request):
    ''' Simple request logging '''
    print '{r.request.method} {r.status_code} {r.elapsed} {r.url}'.format(r=request)

