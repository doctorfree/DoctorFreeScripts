#!/bin/bash
#
# md2man - Uses Github flavored markdown input and pandoc to generate man pages
#    md2man generates a markdown template for input (if none exists)
#    with sections and as much info as it can derive from command line arguments.
#
#    See https://pandoc.org/ for Pandoc info
#
# Author: Ron Record <gitlab@ronrecord.com>
#

# Default input/output directory
MANDIR=${HOME}/src/doc
OUTDIR=${MANDIR}
INPDIR=${MANDIR}
USAGE=
QUIET=
HERE=`pwd`
DATE=`date +'%B %d, %Y'`

# Are we in a git repository with remote origin url?
# If so then this should return something of the form
# ssh://gitlab.com/doctorfree/DoctorFreeScripts.git
URL=`git config --get remote.origin.url`
if [ "${URL}" ]
then
  GIT_HOST=`echo ${URL} | awk -F '/' ' { print $3 } '`
  GIT_USER=`echo ${URL} | awk -F '/' ' { print $4 } '`
  PROJECT=`echo ${URL} | awk -F '/' ' { print $5 } ' | sed -e "s/\.git//"`
else
  GIT_HOST="GIT_HOST"
  GIT_USER="GIT_USERNAME"
  PROJECT="PROJECT"
fi

NAME=`git config --get user.name`
EMAIL=`git config --get user.email`
[ "${NAME}" ] || NAME="YOUR NAME"
[ "${EMAIL}" ] || EMAIL="YOUR EMAIL"

# Default command name, version, and man section
comname="COMMAND"
VERSION="1.0.0"
section="1"

usage() {
    printf "\nUsage:\n\tmd2man [-n command-name] [-s man-section] "
    printf "[-v command-version] [-qu]"
    printf "\n\tWhere:\n\t\t-u displays this usage message"
    printf "\n\t\t-q indicates quiet execution, no messages or prompts"
    printf "\n\t\t-n command-name specifies the name of the command (without section)"
    printf "\n\t\t-s man-section specifies the specifies the man page section number"
    printf "\n\t\t-v command-version specifies the version of the command"
    printf "\n\tMarkdown input located in ${INPDIR}"
    printf "\n\tMan page output located in ${OUTDIR}"
    printf "\n\tAuthor Name and Email are retrieved from git global config variables"
    printf "\n\t(Currently using Name=${NAME} and Email=${EMAIL})"
    printf "\nSummary:\n\tmd2man uses markdown input and pandoc"
    printf " to generate man pages"
    printf "\nExample:\n\tmd2man -n foo -s 3 -v 2.0.1"
    printf "\nDescription:\n\tGenerates a markdown template for input (if none exists)"
    printf "\n\twith command name, sections, version, and as much info"
    printf "\n\tas it can derive from command line arguments and git config."
    printf "\n\tSee https://pandoc.org/ for Pandoc info."
    printf "\nAuthor:\n\t${NAME} <${EMAIL}>\n\n"
    exit 1
}

[ -f VERSION ] && . ./VERSION

while getopts n:s:v:qu flag; do
    case $flag in
        n)
            comname="$OPTARG"
            ;;
        s)
            section="$OPTARG"
            ;;
        v)
            VERSION="$OPTARG"
            ;;
        q)
            QUIET=1
            ;;
        u)
            USAGE=1
            ;;
	esac
done
shift $(( OPTIND - 1 ))

# Use awk to get Unicode support
capcomm=`echo "${comname}" | awk 'BEGIN { getline; print toupper($0) }'`
# Use tr for compatibility with earlier versions of Bash
capfirst="$(tr '[:lower:]' '[:upper:]' <<< ${comname:0:1})${comname:1}"

# Check for markdown and man subdirs in current directory
# If both directories exist then set MANDIR and OUTPUT dirs
[ -d markdown ] && [ -d man ] && {
    INPDIR=${HERE}/markdown
    MANDIR=${HERE}/man
    OUTDIR=${MANDIR}/man${section}
}

[ "${USAGE}" ] && usage

[ -d "${INPDIR}" ] || mkdir -p "${INPDIR}"
[ -d "${OUTDIR}" ] || mkdir -p "${OUTDIR}"

[ -f "${INPDIR}/${comname}.${section}.md" ] || {
echo "---
title: ${capcomm}
section: ${section}
header: User Manual
footer: ${comname} ${VERSION}
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
Submit bug reports online at: &lt;https://${GIT_HOST}/${GIT_USER}/${PROJECT}/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://${GIT_HOST}/${GIT_USER}/${PROJECT}&gt;
" > "${INPDIR}/${comname}.${section}.md"
}

inst_pandoc=`type -p pandoc`
plat=`uname -s`

[ "${inst_pandoc}" ] || {
    if [ "$plat" == "Darwin" ]
    then
      INSTCOMM="brew install pandoc"
    else
      debian=
      [ "${ID_LIKE}" == "debian" ] && debian=1
      [ "${debian}" ] || [ -f /etc/debian_version ] && debian=1
      if [ "${debian}" ]
      then
          INSTCOMM="sudo apt install pandoc"
      else
          INSTCOMM="sudo yum install pandoc"
      fi
    fi
    echo "Cannot locate pandoc in the execution PATH."
    echo "Install pandoc with the command:"
    printf "\n\t${INSTCOMM}\n\n"
    while true
    do
      read -p "Do you wish to install pandoc now ? ('Y'/'N'): " yn
      case $yn in
          [Yy]*)
              ${INSTCOMM}
              break
              ;;
          [Nn]*)
              echo "Exiting."
              exit 1
              break
              ;;
          * )
              echo "Please answer yes or no."
              ;;
      esac
    done
}

[ "${QUIET}" ] || {
    echo "Using ${INPDIR}/${comname}.${section}.md as markdown input"
    echo "Using ${OUTDIR}/${comname}.${section} as man page output"
}

# Use Github flavored markdown as input, Man page format as output
pandoc -f gfm+definition_lists -s -t man -o ${OUTDIR}/${comname}.${section} \
                           ${INPDIR}/${comname}.${section}.md 

[ "${QUIET}" ] || {
  while true
  do
    read -p "Do you wish to view the generated ${comname}.${section} man page ? ('Y'/'N'): " yn
    case $yn in
      [Yy]*)
          if [ "$plat" == "Darwin" ]
          then
              man -M `dirname ${OUTDIR}` ${comname}
          else
              man -l ${OUTDIR}/${comname}.${section}
          fi
          break
          ;;
      [Nn]*)
          break
          ;;
      * )
          echo "Please answer yes or no."
          ;;
    esac
  done
}
