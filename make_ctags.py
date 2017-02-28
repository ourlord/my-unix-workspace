#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Author: OurLord
#
# Used for creating ctags files for Affirmed build machine workspace
#
# Usage:
#       ./make_ctags.py [workspace]
#
# The script would expect the workspace is distributed in the same level under WS_BASE_LOCATION
#
# My workspace architecture looks like this:
# ~/workspace/ +- p1 +- wsroot +- projects +- sub1a
#              |                           |- sub1b
#              |
#              +- p2 +- wsroot +- projects +- sub2a
#                                          |- sub2b
#


import os
import subprocess
import sys
#from termcolor import colored

# not recommend to use the env because the crontab might be triggered by a different user or group
#CURUSER = os.environ['USER']
CURUSER = 'ourlord'
WS_BASE_LOCATION = '~/workspace'
WS_ROOT_DIRNAME = 'wsroot'
SUBMODULE_DIRNAME = 'projects'
PROJECT_DIR = os.path.join(WS_ROOT_DIRNAME, SUBMODULE_DIRNAME)

CTAGS_EXTRA_EXCLUDE = '--exclude=tools --exclude=*.js'
CTAGS_CMD = 'ctags -R --fields=+l --exclude=.* ' + CTAGS_EXTRA_EXCLUDE

# Give some colorful output here
# Useless if this is triggered by crontab LOL
class bcolors:
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

    @staticmethod
    def print_color(s, color = ''):
        if color == 'red':
            print bcolors.FAIL + s + bcolors.ENDC
        elif color == 'green':
            print bcolors.OKGREEN + s + bcolors.ENDC
        else:
            print s

def print_help():
    print "Usage: ./make_ctags ([workspace_name])"
    print "     if workspace is not specified, the script will run against current location"

def main(workspace = ""):
    sub(workspace)

# Generate a global tags file under 'projects' directory
def sub(workspace = ""):
    # run this script without given a workspace name
    path = ''
    if workspace == "":
        workspace = os.getcwd()   # get current path - where the script is running
        # Handle failure cases
        if WS_BASE_LOCATION not in workspace:
            bcolors.print_color('Should run in ' + WS_BASE_LOCATION + '/<workspace> if no workspace name is indicate when running the script')
            return
        elif WS_BASE_LOCATION == workspace or WS_BASE_LOCATION + '/' == workspace:
            bcolors.print_color('Should run in ' + WS_BASE_LOCATION + '/<workspace> if no workspace name is indicate when running the script')
            return
        # Process the path we should work on
        if PROJECT_DIR in workspace:
            if os.path.basename(workspace) == SUBMODULE_DIRNAME:
                path = workspace
            else:
                bcolors.print_color('Shuold run this command in the ' + WS_BASE_LOCATION + '/<workspace>')
                return
        elif WS_ROOT_DIRNAME in workspace:
            path = os.path.join(workspace, SUBMODULE_DIRNAME)
        else:
            path = os.path.join(workspace, PROJECT_DIR)
    # given a workspace when run the script
    else:
        trypath = os.path.join(WS_BASE_LOCATION, workspace)
        if WS_ROOT_DIRNAME in os.listdir(trypath):
            path = os.path.join(WS_BASE_LOCATION, workspace, PROJECT_DIR)
        else:
            for d in os.listdir(trypath):
                if os.path.isdir(os.path.join(trypath, d)) and WS_ROOT_DIRNAME in os.listdir(os.path.join(trypath, d)):
                    path = os.path.join(WS_BASE_LOCATION, workspace, d, PROJECT_DIR)
    # try to go to the path to see if it exists
    try:
        os.chdir(path)
    except OSError as e:
        bcolors.print_color('path [' + path + '] not found! Abort')
        return
    bcolors.print_color('generate ctags under :' + os.getcwd())
    subprocess.call(CTAGS_CMD, shell = True)
    bcolors.print_color('tags file are generated')

if __name__ == '__main__':
    if len(sys.argv) > 1:
        if 'help' in sys.argv[1] or '--help' in sys.argv[1] or '-h' in sys.argv[1]:
            print_help()
        else:
            main(sys.argv[1])
    else:
        main()