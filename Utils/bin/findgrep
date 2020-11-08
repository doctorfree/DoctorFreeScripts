#!/bin/bash
#
## @file findgrep.sh
## @brief Recursive grep in current directory
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @version 1.0.1
##
## Yes, it's a simple one liner but since I use it all the time and the
## -print0 and -0 arguments to find and xargs are somewhat obscure (these
## are necessary so the find | grep works on systems that support spaces
## in filenames), I'm including it here in my Scripts repository.
#

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
Usage() {
    printf "Usage: findgrep [all the options to grep] string\n"
    printf "\tGrep for 'string' recursively from the current directory\n"
    printf "\nExamples:\n\tLocate all files in the current directory and below"
    printf "\n\twhich contain the string 'foobarspam'"
    printf "\n\t\tfindgrep -l foobarspam\n"
    printf "\n\tDisplay all lines from files in the current directory and"
    printf "\n\tbelow which contain the string 'foobarspam'"
    printf "\n\t\tfindgrep foobarspam\n"
    printf "\n\tDisplay all lines from files in the current directory and"
    printf "\n\tbelow which contain the string 'foobarspam', ignoring case"
    printf "\n\t\tfindgrep -i foobarspam\n\n"
    exit 1
}

[ $# -eq 0 ] && Usage

find . -type f -print0 | xargs -0 grep $*
