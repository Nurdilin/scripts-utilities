'''
    Collection of Atlassian Exceptions
'''

class AtlassianConnectionError(Exception):
    ''' Custom exception handler for connection issues '''
    def __init__(self, response):
        message = 'Failed to connect to {0}: ({1} {2}'.format(
            response.url,
            response.status_code,
            response.content
        )
        super(AtlassianConnectionError, self).__init__(message)
        self.response = response
