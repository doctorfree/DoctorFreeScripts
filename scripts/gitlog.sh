#!/bin/bash
#
## @file gitlog.sh
## @brief Pretty format the output of "git log ..."
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 11-Mar-2015
## @version 1.0.1
##
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#
## Useful options for git log --pretty=format
##
## Option    Description of Output
## 
## %H    Commit hash
## %h    Abbreviated commit hash
## %T    Tree hash
## %t    Abbreviated tree hash
## %P    Parent hashes
## %p    Abbreviated parent hashes
## %an   Author name
## %ae   Author e-mail
## %ad   Author date (format respects the --date=option)
## %ar   Author date, relative
## %cn   Committer name
## %ce   Committer email
## %cd   Committer date
## %cr   Committer date, relative
## %s    Subject
##
## General git log options
##
## -p    Show the patch introduced with each commit.
## --stat Show statistics for files modified in each commit.
## --shortstat Display only the changed/insertions/deletions line from
##             the --stat command.
## --name-only Show the list of files modified after the commit information.
## --name-status Show the list of files affected with added/modified/deleted
##               information as well.
## --abbrev-commit Show only the first few characters of the SHA-1 checksum
##                 instead of all 40.
## --relative-date Display the date in a relative format (for example, “2 weeks
##                 ago”) instead of using the full date format.
## --graph Display an ASCII graph of the branch and merge history beside the
##         log output.
## --pretty Show commits in an alternate format. Options include oneline, short,
##          full, fuller, and format (where you specify your own format).
##
## Options to filter output of git log
##
## -(n) Show only the last n commits
## --since, --after Limit the commits to those made after the specified date.
## --until, --before Limit the commits to those made before the specified date.
## --author Only show commits in which the author entry matches the
##          specified string.
## --committer Only show commits in which the committer entry matches the
##             specified string.
## --grep Only show commits with a commit message containing the string
## -S Only show commits adding or removing code matching the string
## 
## The last really useful option to pass to git log as a filter is a path.
## If you specify a directory or file name, you can limit the log output to
## commits that introduced a change to those files. This is always the last
## option and is generally preceded by double dashes (--) to separate the
## paths from the options.

DAYS=1
SINCE=
NAME_ONLY=
REVERSE=
USAGE=
FULL=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "Usage: gitlog [-f] [-n] [-r] [-s days] [-u]\n"
    printf "Where:\n\t-n indicates name-only output mode"
    printf "\n\t-f specifies full log output (do not pretty format the output)"
    printf "\n\t-r displays the log entries in reverse order.\n"
    printf "\n\t-s # specifies log output for the last # days only"
    printf "\n\t-u displays this usage message.\n"
    printf "\nWould have executed the following command:"
    if [ "$FULL" ]
    then
        printf "\n\tgit log $REVERSE $NAME_ONLY $SINCE\n\n"
    else
        printf "\n\tgit log $REVERSE --pretty=format:\"%%an, %%ad %%h :%%n   %%s\" $NAME_ONLY $SINCE\n\n"
    fi
    exit 1
}

while getopts fnrs:u flag; do
    case $flag in
        f)
            FULL=1
            ;;
        n)
            NAME_ONLY="--name-only";
            ;;
        r)
            REVERSE="--reverse";
            ;;
        s)
            SINCE="--since=$OPTARG.days";
            ;;
        u)
            USAGE=1
            ;;
   esac
done
shift $(( OPTIND - 1 ));

if [ "$USAGE" ]
then
    usage
else
    if [ "$FULL" ]
    then
        git log $REVERSE $NAME_ONLY $SINCE
    else
        git log $REVERSE --pretty=format:"%an, %ad %h :%n   %s" $NAME_ONLY $SINCE
     fi
fi

