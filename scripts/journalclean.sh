#!/bin/bash
#
## @file journalclean.sh
## @brief Clean the journal logging if it exceeds max size
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2022, Ronald Joe Record, all rights reserved.
## @date Written 25-Jan-2022
## @version 1.0.1
##
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
    printf "\nUsage: journalclean [-d days] [-w weeks] [-m months]\n"
    printf "\t[-M Megabytes] [-G Gigabytes] [-n] [-q] [-r] [-u]\n"
    printf "\nWhere:\n\t-r indicates report disk space used\n"
    printf "\t-d 'days' deletes journal entries older than 'days' days\n"
    printf "\t-w 'weeks' deletes journal entries older than 'weeks' weeks\n"
    printf "\t-m 'months' deletes journal entries older than 'months' months\n"
    printf "\t-M 'MB' reduces size of journal to less than 'MB' Megabytes\n"
    printf "\t-G 'GB' reduces size of journal to less than 'GB' Gigabytes\n"
    printf "\t-n indicates tell me what you would do without doing it\n"
    printf "\t-q indicates quiet mode\n"
    printf "\t-u displays this usage message\n"
    printf "\nDefault action if no arguments are given is to reduce size to max 1GB\n"
    printf "\nAlternatively, edit the file '/etc/systemd/journald.conf'\n"
    printf "and execute 'sudo systemctl restart systemd-journald'\n"
    printf "\nFor example, to limit journal size to 1GB add the journald.conf entry:"
    printf "\n\tSystemMaxUse=1G\n"
    exit 1
}

QUIET=
TELL=
DAYS=
WEEKS=
MONTHS=
MB=
GB=1
while getopts d:w:m:M:G:rnqu flag; do
    case $flag in
        d)
            DAYS=${OPTARG}
            ;;
        w)
            WEEKS=${OPTARG}
            ;;
        m)
            MONTHS=${OPTARG}
            ;;
        G)
            GB=${OPTARG}
            ;;
        M)
            MB=${OPTARG}
            ;;
        r)
            journalctl --disk-usage
            exit 0
            ;;
        n)
            TELL=1
            ;;
        q)
            QUIET="--quiet"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "${TELL}" ] || sudo journalctl --rotate
[ "${DAYS}" ] && {
    if [ "${TELL}" ]
    then
        echo "sudo journalctl ${QUIET} --vacuum-time=${DAYS}d"
    else
        sudo journalctl ${QUIET} --vacuum-time=${DAYS}d
    fi
    exit 0
}
[ "${WEEKS}" ] && {
    if [ "${TELL}" ]
    then
        echo "sudo journalctl ${QUIET} --vacuum-time=${WEEKS}w"
    else
        sudo journalctl ${QUIET} --vacuum-time=${WEEKS}w
    fi
    exit 0
}
[ "${MONTHS}" ] && {
    if [ "${TELL}" ]
    then
        echo "sudo journalctl ${QUIET} --vacuum-time=${MONTHS}m"
    else
        sudo journalctl ${QUIET} --vacuum-time=${MONTHS}m
    fi
    exit 0
}

[ "${MB}" ] && {
    if [ "${TELL}" ]
    then
        echo "sudo journalctl ${QUIET} --vacuum-size=${MB}M"
    else
        sudo journalctl ${QUIET} --vacuum-size=${MB}M
    fi
    exit 0
}
[ "${GB}" ] && {
    if [ "${TELL}" ]
    then
        echo "sudo journalctl ${QUIET} --vacuum-size=${GB}G"
    else
        sudo journalctl ${QUIET} --vacuum-size=${GB}G
    fi
    exit 0
}
