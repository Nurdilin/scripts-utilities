#!/usr/bin/env python

'''
    Script to setup BitBucket Server repositories
'''

from argparse                           import ArgumentParser
from libs                     import bitbucket
from libs.bitbucket.resources import Permission

import base64
import getpass
import re

def configure_repository(server, project, repo, permissions, reviewers):
    ''' Configure a BitBucket Repository '''

    print '\nConfiguring {p}/{r}'.format(p=project, r=repo)

    # Configure pull request settings
    # server.set_pull_request_settings(project, repo)

    # Configure default reviewers
    conditions = server.get_default_reviewers(project, repo)
    if len(conditions):
        server.update_default_reviewers(project, repo, conditions[0]['id'], reviewers)
    else:
        server.create_default_reviewers(project, repo, reviewers)

    # Configure branch permissions
   # server.delete_all_repo_permissions(project, repo)
   # for permission in permissions:
   #     server.create_repo_permission(project, repo, permission)


def main():
    ''' Main function '''

    parser = ArgumentParser()
    parser.add_argument('--user',    dest='user',    type=str, default=getpass.getuser(),               help='Override the default environment user')
    parser.add_argument('--token',   dest='token',   type=str, default=None,                            help='Use basic auth token to connect to BitBucket')
    parser.add_argument('--project', dest='project', type=str, default='MY_PRO',                           help='Project the repository lives in')
    parser.add_argument('--repo',    dest='repo',    type=str, default=None,                            help='Optional, repository to configure')
    parser.add_argument('--server',  dest='server',  type=str, default='https://stash.int.company.com', help='BitBucket Server URL')
    args = parser.parse_args()

    if args.repo is None:
        # Run for all repos in project... REALLY?!
        if not re.match(r'^[y(yes)]', raw_input('You want to run this all on all repos in {0}?! Are you sure? [Y/n]\n'.format(args.project)), re.IGNORECASE):
            exit()
        else:
            print "\nOkay... You're the boss!\n"

    # Prefer to setup using basic auth so this can be used in a script
    if args.token is None:
        args.token = base64.b64encode('{0}:{1}'.format(args.user, getpass.getpass('BitBucket Password:')))

    server = bitbucket.BitBucketServer.by_token(args.token, {'server': args.server})

    # Get User properties
    user1  = server.get_user('user1')
    user2  = server.get_user('user2')

    # Construct reviewer and permissions lists
    reviewers = [user1,user2]

    # Permissions to create
    permissions = [
    ]

    if args.repo:
        # Run for single repo
        configure_repository(server, args.project, args.repo, permissions, reviewers)
    else:
        # Run for all repos in project
        for repo in server.get_repos_iter(args.project):
            configure_repository(server, args.project, repo.slug, permissions, reviewers)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print '\nAborting...'
