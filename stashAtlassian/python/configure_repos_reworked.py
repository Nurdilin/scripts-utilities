#!/usr/bin/env python

'''
    Script to setup BitBucket Server repositories
'''
import base64
import getpass
import re

from argparse			import ArgumentParser
from libs			import bitbucket
from libs.bitbucket.resources	import Permission

def configure_repository(server, project, repo, permissions, reviewers):
    ''' Configure a BitBucket Repository '''

    print '\nConfiguring {p}/{r}'.format(p=project, r=repo)

    # Configure pull request settings: 
    # server.set_pull_request_settings(project, repo)

    # Configure default reviewers
    server.create_default_reviewers(project, repo, reviewers)

    #conditions = server.get_default_reviewers(project, repo)
    #if len(conditions):
    #    server.update_default_reviewers(project, repo, conditions[0]['id'], reviewers)
    #else:
    #    server.create_default_reviewers(project, repo, reviewers)

    # Configure branch permissions
    # server.delete_all_repo_permissions(project, repo)
    # for permission in permissions:
    #     server.create_repo_permission(project, repo, permission)


def main():
    ''' Main function '''

    parser = ArgumentParser()
    parser.add_argument('--user',    dest='user',    type=str, default=getpass.getuser(),               help='Override the default environment user')
    parser.add_argument('--pwd',     dest='pwd',     type=str, default=None,                            help='Use password to connect to BitBucket')
    parser.add_argument('--token',   dest='token',   type=str, default=None,                            help='Use basic auth token to connect to BitBucket')
    parser.add_argument('--project', dest='project', type=str, default='MY_COM',                          help='Project the repository lives in')
    parser.add_argument('--repo',    dest='repo',    type=str, default=None,                            help='Optional, repository to configure')
    parser.add_argument('--server',  dest='server',  type=str, default='https://stash.int.company.com', help='BitBucket Server URL')
    args = parser.parse_args()

    if args.repo is None:
        # Run for all repos in project
        if re.match(r'^(y|yes)$', raw_input('Running this on all repos in {0} [Y/n]\n'.format(args.project)), re.IGNORECASE):
            print "\nOk!\n"
            args.repo = 'all'
        else:
            exit()

    # Prefer to setup using basic auth so this can be used in a script
    if args.token is None:
        if args.pwd is None:
            args.pwd = getpass.getpass('BitBucket Password: ')

        args.token = base64.b64encode('{0}:{1}'.format(args.user, args.pwd))

    server = bitbucket.BitBucketServer.by_token(args.token, {'server': args.server})
    #server = bitbucket.BitBucketServer.by_credentials(args.user, args.pwd, {'server': args.server})

    # Construct reviewer and permissions lists
    reviewers = [
        server.get_user('user1'),
        server.get_user('user2')
    ]

    # Permissions to create
    permissions = [
    ]

    if args.repo.lower() == 'all':
        # Run for all repos in project except the...
        # release-steps where Release Engineers should be the only ones approving
        for repo in server.get_repos_iter(args.project):
            if repo.slug == "release-steps":
                continue
            configure_repository(server, args.project, repo.slug, permissions, reviewers)
    else:
        # Run for single repo
        configure_repository(server, args.project, args.repo, permissions, reviewers)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print '\nAborting...'
