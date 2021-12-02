#!/bin/bash
#
## @file updgit.sh
## @brief Perform git add/commit/push to the repo associated with this clone
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 8-Mar-2014
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

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
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

# One of the actual changes that came about as a result of the
# many protests in the aftermath of the murder of George Floyd
# during his arrest by Minneapolis police officers on May 25, 2020
# was GitHub and GitLab changing the name of the default branch
# from "master" to "main". It will be left as an exercise for the
# reader to determine if this change addressed the problem of
# systemic racism in the United States and around the world.

# Try to figure out the name of the branch to push to
branch="master"
[ -f ./.git/config ] && {
    confbranch=`cat ./.git/config | grep ^\\\[branch |
                awk ' { print $2 } ' |
                sed -e "s/\"//g" -e "s/\]//"`
}
[ "${confbranch}" ] && branch="${confbranch}"

echo "git push origin ${branch}"
[ "$TELL" ] || git push origin ${branch}
