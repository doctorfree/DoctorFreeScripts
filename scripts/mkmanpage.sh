#!/bin/bash
#
# mkmanpage - uses markdown input and pandoc to generate man pages
#    mkmanpage generates a markdown template for input (if none exists)
#    with sections and as much info as it can derive from command line arguments.
#
#    See https://pandoc.org/ for Pandoc info
#
# Author: Ron Record <gitlab@ronrecord.com>
#

MANDIR=${HOME}/src/doc
DATE=`date +'%B %d, %Y'`
NAME=`git config --global --get user.name`
EMAIL=`git config --global --get user.email`
[ "${NAME}" ] || NAME="YOUR NAME"
[ "${EMAIL}" ] || EMAIL="YOUR EMAIL"

# Default command name, version, and man section
comname="COMMAND"
version="1.0.0"
section="1"

usage() {
    printf "\nUsage:\n\tmkmanpage [-n command-name] [-s man-section] "
    printf "[-v command-version] [-u]"
    printf "\n\tWhere:\n\t\t-u displays this usage message"
    printf "\n\t\t-n command-name specifies the name of the command (without section)"
    printf "\n\t\t-s man-section specifies the specifies the man page section number"
    printf "\n\t\t-v command-version specifies the version of the command"
    printf "\n\tMarkdown input and Man page output are located in ${MANDIR}"
    printf "\n\tAuthor Name and Email are retrieved from git global config variables"
    printf "\n\t(Currently using Name=${NAME} and Email=${EMAIL})"
    printf "\nSummary:\n\tmkmanpage uses markdown input and pandoc"
    printf " to generate man pages"
    printf "\nExample:\n\tmkmanpage -n foo -s 3 -v 2.0.1"
    printf "\nDescription:\n\tGenerates a markdown template for input (if none exists)"
    printf "\n\twith command name, sections, version, and as much info"
    printf "\n\tas it can derive from command line arguments and git config."
    printf "\n\tSee https://pandoc.org/ for Pandoc info."
    printf "\nAuthor:\n\tRon Record <gitlab@ronrecord.com>\n\n"
    exit 1
}

while getopts n:s:v:u flag; do
    case $flag in
        n)
            comname="$OPTARG"
            ;;
        s)
            section="$OPTARG"
            ;;
        v)
            version="$OPTARG"
            ;;
        u)
            usage
            ;;
	esac
done
shift $(( OPTIND - 1 ))

# Use awk to get Unicode support
capcomm=`echo "${comname}" | awk 'BEGIN { getline; print toupper($0) }'`
# Use tr for compatibility with earlier versions of Bash
capfirst="$(tr '[:lower:]' '[:upper:]' <<< ${comname:0:1})${comname:1}"

[ -f "${MANDIR}/${comname}.${section}.md" ] || {
echo "---
title: ${capcomm}
section: ${section}
header: User Manual
footer: ${comname} ${version}
date: ${DATE}
---
# NAME
${comname} - PLACE BRIEF SUMMARY HERE

# SYNOPSIS
**${comname}** [*OPTION*]...

# DESCRIPTION
**${comname}** PLACE DESCRIPTION HERE

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: ADDITIONAL OPTIONS

# CONFIGURATION
CONFIGURATION INFO

# EXAMPLES
**${comname} -n Arg**
: EXAMPLE DESCRIPTION GOES HERE

# AUTHORS
Written by ${NAME} &lt;${EMAIL}&gt;

# LICENSING
${capfirst} is distributed under an Open Source license.
See the file "LICENSE" in the ${capfirst} source distribution
for information on terms &amp; conditions for accessing and
otherwise using ${capfirst} and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/PROJECT/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/PROJECT&gt;
" > "${MANDIR}/${comname}.${section}.md"
}

inst_pandoc=`type -p pandoc`

[ "${inst_pandoc}" ] || {
    echo "Cannot locate pandoc in the execution PATH."
    echo "Install pandoc with 'sudo apt install pandoc'"
    echo "Exiting."
    exit 1
}

cd "${MANDIR}"

pandoc ${comname}.${section}.md -s -t man -o ${comname}.${section}
