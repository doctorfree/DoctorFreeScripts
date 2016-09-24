#!/bin/bash
#
# updgit - perform the git add, git commit, and git push to the remote
#          repository associated with this clone.
#
# Written 8-Mar-2014 by Ronald Joe Record <rr at ronrecord dot com>
#
# Copyright (c) 2014, Ronald Joe Record
# All rights reserved.
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

usage() {
    printf "\nUsage: updgit [-u] [-a] [-d] [-m \"message comment\"] [file1 ...]"
    printf "\nWhere:"
    printf "\n\t-u displays this usage message."
    printf "\n\t-a indicates to commit all staged files."
    printf "\n\t-d indicates to demonstrate what you would do without doing it."
    printf "\n\t-m comment adds the comment string as the commit message."
    printf "\n\t   \"comment message\" must be enclosed in quotes."
    printf "\n\tfile1 file2 ... lists files to be staged and commited."
    printf "\n\tNote, you must either specify -a or a list of file(s).\n\n"
    exit 1
}

COMMENT=
TELL=
ALL=
ADD=
while getopts am:du flag; do
    case $flag in
        a)
            ALL=1
            ADD="-a"
            ;;
        d)
            TELL=1
            ;;
        m)
            COMMENT="$OPTARG"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

echo ""
# Check filename arguments to verify they exist or are not needed
if [ "$ALL" ]
then
    [ $# -eq 0 ] || {
        echo "Filename arguments with -a doesn't make sense."
        echo "Exiting."
        usage
    }
else
    [ $# -eq 0 ] && {
        echo "No filename arguments. Did you mean to use the -a argument ?"
        echo "Exiting."
        usage
    }
fi
for i in "$@"
do
    [ -f "$i" ] || {
        echo "At least one of your filename arguments: $i"
        echo "does not exist or is not a plain file. Exiting."
        usage
    }
done

[ "$ALL" ] || {
    echo "git add $@"
    [ "$TELL" ] || git add $@
}
if [ "$COMMENT" ]
then
    echo "git commit $ADD -m \"$COMMENT\""
else
    echo "git commit $ADD"
fi
[ "$TELL" ] || {
    if [ "$COMMENT" ]
    then
        git commit $ADD -m "$COMMENT"
    else
        git commit $ADD
    fi
}
echo "git push origin master"
[ "$TELL" ] || git push origin master
