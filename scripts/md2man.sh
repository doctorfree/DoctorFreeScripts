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
ALL=
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
comname=""
VERSION="1.0.0"
section="1"

usage() {
    printf "\nUsage:\n\tmd2man [-n command-name] [-s man-section] "
    printf "[-v command-version] [-aqu]"
    printf "\n\tWhere:\n\t\t-u displays this usage message"
    printf "\n\t\t-a indicates generate all man pages from markdown found in ./markdown"
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

mkmanfrom() {
    command_name="$1"
    command_sect="$2"
    # Use awk to get Unicode support
    capcomm=`echo "${command_name}" | awk 'BEGIN { getline; print toupper($0) }'`

    [ -f "${INPDIR}/${command_name}.${command_sect}.md" ] || {
        echo "---
title: ${capcomm}
section: ${command_sect}
header: User Manual
footer: ${command_name} ${VERSION}
date: ${DATE}
---
# NAME
**${command_name}** - PLACE BRIEF SUMMARY HERE

# SYNOPSIS
**${command_name}** [ **OPTION** ARG ]

# DESCRIPTION
PLACE DESCRIPTION HERE

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: ADDITIONAL OPTIONS

# EXAMPLES
**${command_name} -n Arg**
: EXAMPLE DESCRIPTION GOES HERE

# AUTHORS
Written by ${NAME} &lt;${EMAIL}&gt;

# LICENSING
${capcomm} is distributed under an Open Source license.
See the file "LICENSE" in the ${capcomm} source distribution
for information on terms &amp; conditions for accessing and
otherwise using ${capcomm} and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://${GIT_HOST}/${GIT_USER}/${PROJECT}/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://${GIT_HOST}/${GIT_USER}/${PROJECT}&gt;
" > "${INPDIR}/${command_name}.${command_sect}.md"
    }

    [ "${QUIET}" ] || {
        echo "Using ${INPDIR}/${command_name}.${command_sect}.md"
        echo "as markdown input"
        echo ""
        echo "Using ${OUTDIR}/${command_name}.${command_sect}"
        echo "as man page output"
        echo ""
    }

    # Use Github flavored markdown as input, Man page format as output
    pandoc -f gfm+definition_lists -s -t man \
           -o ${OUTDIR}/${command_name}.${command_sect} \
              ${INPDIR}/${command_name}.${command_sect}.md 

    [ "${QUIET}" ] || {
      while true
      do
        read -p "Do you wish to view the generated ${command_name}.${command_sect} man page ? ('Y'/'N'): " yn
        case $yn in
          [Yy]*)
              if [ "$plat" == "Darwin" ]
              then
                  man -M `dirname ${OUTDIR}` ${command_name}
              else
                  man -l ${OUTDIR}/${command_name}.${command_sect}
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
}

[ -f VERSION ] && . ./VERSION

while getopts an:s:v:qu flag; do
    case $flag in
        a)
            ALL=1
            QUIET=1
            ;;
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

[ "${ALL}" ] && {
  # Check to see if there are any markdown files to process
  for mdf in markdown/*.md
  do
    [ "${mdf}" == "markdown/*.md" ] && ALL=
  done
}

if [ "${ALL}" ]
then
  for mdf in markdown/*.md
  do
    [ "${mdf}" == "markdown/*.md" ] && continue
    [ "${mdf}" == "markdown/README.md" ] && continue
    comname=`basename ${mdf} | awk -F '.' ' { print $1 } '`
    comsect=`basename ${mdf} | awk -F '.' ' { print $2 } '`
    echo "Processing ${comname}.${comsect}"
    mkmanfrom ${comname} ${comsect}
  done
else
  [ "${comname}" ] || {
    if [ "$1" ]
    then
      comname=$*
    else
      echo "No command name provided. Using 'COMMAND' as command name."
      comname="COMMAND"
    fi
  }
  for mdf in ${comname}
  do
    mkmanfrom ${mdf} ${section}
  done
fi
