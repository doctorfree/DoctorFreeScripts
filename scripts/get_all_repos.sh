#!/bin/bash
#
# get_all_repos - retrieve all github repos
#   requires gh and jq
#

debug=
dryrun=
help=
output="${HOME}/src"
user="doctorfree"
limit=200
substr=

usage() {
  printf "\nUsage: get_all_repos [-d] [-h] [-l limit] [-n] [-o output] [-s str] [-u user]"
  printf "\nWhere:"
  printf "\n\t-d indicates debug mode"
  printf "\n\t-h displays this usage message and exits"
  printf "\n\t-l 'limit' specifies the limit for number of repositories"
  printf "\n\t-n indicates dry run, tell me what you would do but don't do it"
  printf "\n\t-o 'output' specifies the output directory"
  printf "\n\t-s 'str' specifies a substring repository names must match"
  printf "\n\t-u 'user' specifies the github user\n"
  printf "\nDefaults:"
  printf "\n\tdebug off"
  printf "\n\tdry run off"
  printf "\n\tlimit=200"
  printf "\n\toutput=$HOME/src"
  printf "\n\tuser=doctorfree\n\n"
  exit 1
}

get_repo() {
  repo="$1"
  # Place some doctorfree repositories in subdirectories
  [ "${user}" == "doctorfree" ] && {
    if [[ ${repo} == *"bsidian"* ]]
    then
      if [ "${dryrun}" ]
      then
        echo "[ -d Obsidian ] || mkdir Obsidian"
        echo "cd Obsidian"
      else
        [ -d Obsidian ] || mkdir Obsidian
        cd Obsidian
      fi
    fi
    if [[ ${repo} == "Mirror"* ]] || [[ ${repo} == "MMM-"* ]] || [[ ${repo} == "mmm-"* ]]
    then
      if [ "${dryrun}" ]
      then
        echo "[ -d MagicMirror ] || mkdir MagicMirror"
        echo "cd MagicMirror"
      else
        [ -d MagicMirror ] || mkdir MagicMirror
        cd MagicMirror
      fi
    fi
  }
  if [ -d ${repo} ]
  then
    echo "Performing git pull for ${repo}"
    if [ "${dryrun}" ]
    then
      echo "cd ${repo}"
    else
      cd ${repo}
    fi
    if [ "${debug}" ]
    then
      if [ "${dryrun}" ]
      then
        echo "git pull"
      else
        git pull
      fi
    else
      if [ "${dryrun}" ]
      then
        echo "git pull > /dev/null 2>&1"
      else
        git pull > /dev/null 2>&1
      fi
    fi
  else
    echo "Cloning ${repo}"
    if [ "${debug}" ]
    then
      if [ "${dryrun}" ]
      then
        echo "gh repo clone ${user}/${repo}"
      else
        gh repo clone ${user}/${repo}
      fi
    else
      if [ "${dryrun}" ]
      then
        echo "gh repo clone ${user}/${repo} > /dev/null 2>&1"
      else
        gh repo clone ${user}/${repo} > /dev/null 2>&1
      fi
    fi
  fi
  if [ "${dryrun}" ]
  then
    echo "cd ${output}"
  else
    cd "${output}"
  fi
}

while getopts "dhl:no:s:u:" flag; do
  case $flag in
    d)
      debug=1
      ;;
    h)
      help=1
      ;;
    l)
      limit="$OPTARG"
      ;;
    n)
      dryrun=1
      ;;
    o)
      output="$OPTARG"
      ;;
    s)
      substr="$OPTARG"
      ;;
    u)
      user="$OPTARG"
      ;;
  esac
done
shift $(( OPTIND - 1 ))

[ "${help}" ] && usage

[ -d "${output}" ] || {
  if [ "${dryrun}" ]
  then
    echo "mkdir -p ${output}"
  else
    mkdir -p "${output}"
  fi
}
if [ "${dryrun}" ]
then
  echo "cd ${output}"
else
  cd "${output}"
fi

gh repo list --limit ${limit} --json name | \
jq --raw-output '.[]?.name' | \
while read name
do
  if [ "${substr}" ]
  then
    [[ ${name} == *"${substr}"* ]] && get_repo ${name}
  else
    get_repo ${name}
  fi
done
