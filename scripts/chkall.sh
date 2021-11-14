#!/bin/bash
#
## @file chkall.sh
## @brief Invokes chk to check & sync the media rsync'd directories
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 23-Feb-2014
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
    printf "Usage: chkall [-f] [-h] [-H] [-n] [-r] [-u]\n"
    printf "Where:\n\t-n indicates tell me what you would do without doing it\n"
    printf "\t-f indicates force a sync regardless of last time-stamp\n"
    printf "\t-h indicates use directories from $HOME\n"
    printf "\t-H indicates also sync directories in $HOME\n"
    printf "\t-r indicates run rsync to sync libraries when needed\n"
    printf "\t-u displays this usage message\n"
    printf "\nExample invocations:\n"
    printf "\tReport which directories are current and which are not\n"
    printf "\t\tchkall\n"
    printf "\t\tor\n"
    printf "\t\tchkall -n\n"
    printf "\tReport which directories are current and which are not and tell\n"
    printf "\twhat would be done if rsync were invoked\n"
    printf "\t\tchkall -n -r\n"
    printf "\tInvoke rsync on those directories out of sync\n"
    printf "\t\tchkall -r\n"
    printf "\tForce rsync on all directories regardless of time stamp\n"
    printf "\t\tchkall -f -r\n"
    exit 1
}

FORCE=
TELL=
UPD=
MYHOME=
SYNCHOME=
while getopts fhHrnu flag; do
    case $flag in
        f)
            FORCE="-f"
            ;;
        h)
            MYHOME="-h"
            ;;
        H)
            SYNCHOME=1
            ;;
        n)
            TELL="-n"
            ;;
        r)
            UPD="-r"
            ;;
        u)
            usage
            ;;
    esac
done

printf "\nChecking rsync of Aperture libraries ...\n"
chk -L $FORCE $TELL $UPD
printf "\nDone checking Aperture libraries.\n"
printf "\nChecking rsync of iTunes library ...\n"
chk -I $FORCE $TELL $UPD
printf "\nDone checking iTunes library.\n"
printf "\nChecking rsync of Audio ...\n"
chk -A $FORCE $TELL $MYHOME $UPD
printf "\nDone checking Audio.\n"
printf "\nChecking rsync of Movies ...\n"
chk -M $FORCE $TELL $MYHOME $UPD
printf "\nDone checking Movies.\n"
printf "\nChecking rsync of Pictures ...\n"
chk -P $FORCE $TELL $MYHOME $UPD
printf "\nDone checking Pictures.\n"
[ "$SYNCHOME" ] && {
    printf "\nChecking rsync of Home directories ...\n"
    chk -H $FORCE $TELL $MYHOME $UPD
    printf "\nDone checking Home.\n"
}
printf "\nDone.\n"
