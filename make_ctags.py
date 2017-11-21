#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Author: Lincoln X
#
# Used for creating ctags files for Affirmed build machine workspace
#
# Usage:
#       ./make_ctags.py [workspace]
#
# The script would expect the workspace is distributed in the same level under /data/<user>/
# 
# Update (08/08/16):
#   Handling JIRA workspace under /data/<user>/anxxxx. The workspace location in these types of folder is:
#   /data/<user>/anxxx/workspace/anroot
#

import datetime
import os
import subprocess
import sys
#from termcolor import colored

# not recommend to use the env because the crontab might be triggered by a different user or group
#CURUSER = os.environ['USER']
CURUSER = 'lincoln_xiong'
WS_BASE_LOCATION = '/data/' + CURUSER
WS_ROOT_DIRNAME = 'anroot'
SUBMODULE_DIRNAME = 'projects'
PROJECT_DIR = os.path.join(WS_ROOT_DIRNAME, SUBMODULE_DIRNAME)

# HERE GOES THE FILES NOT WANTED TO INCLUDED IN THE CSCOPE.FILES
UNWANTED_FILES = [
        '/linux-3.16.7-debian/',
        '/linux-3.2.46-debian/',
        '/stand_alone/',
        'tos_fastpath/toolkit/',
        ]

CREATE_CSCOPE_FILES = "find ./ -name '*.[ch]' -o -name '*.[ch]pp' -o -name '*.cc' > ./cscope.files"

#CTAGS_EXTRA_EXCLUDE = ' --exclude=tools --exclude=*.js --exclude=tools/stand_alone'
#CTAGS_CMD = 'ctags --fields=+liaS --extra=+q --exclude=.* -L ./cscope.files' + CTAGS_EXTRA_EXCLUDE
#CTAGS_CMD = 'ctags -R --fields=+liaS --extra=+q --exclude=.*' + CTAGS_EXTRA_EXCLUDE
CTAGS_CMD = 'ctags --fields=+liaS --extra=+q -L cscope.files'
CSCOPE_CMD = 'cscope -bqk'

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

def remove_not_wanted_source_files(cscope_filename = "./cscope.files"):
    f = open(cscope_filename, 'r')
    lines = f.readlines()
    f.close()
    f = open(cscope_filename, 'w')
    for l in lines:
        if any(e in l for e in UNWANTED_FILES):
            pass
        else:
            f.write(l)
    f.close()

# Generate a global tags file under 'projects' directory
def sub(workspace = ""):
    start_dt = datetime.datetime.utcnow()
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
    # run cscope
    # create cscope.files first
    subprocess.call(CREATE_CSCOPE_FILES, shell = True)
    remove_not_wanted_source_files()
    # run cscope
    subprocess.call(CSCOPE_CMD, shell = True)
    # run ctags
    subprocess.call(CTAGS_CMD, shell = True)
    delta = datetime.datetime.utcnow() - start_dt
    bcolors.print_color('tags file are generated in ' + str(delta.seconds) + '.' + str(delta.microseconds / 1000) + ' sec')

if __name__ == '__main__':
    if len(sys.argv) > 1:
        if 'help' in sys.argv[1] or '--help' in sys.argv[1] or '-h' in sys.argv[1]:
            print_help()
        else:
            main(sys.argv[1])
    else:
        main()