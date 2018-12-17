'''
    Collection of BitBucket Exceptions
'''

from ..common.exceptions import AtlassianConnectionError

class BitBucketConnectionError(AtlassianConnectionError):
    ''' Custom exception handler for connection issues '''
    def __init__(self, response):
        super(BitBucketConnectionError,  self).__init__(response)
