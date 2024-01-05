#!/bin/bash
#
# Modify 'user' and 'host' with your rsync.net username and hostname
user="<rsync.net username>"
host="<host>.rsync.net"

myhost="$(hostname)"
dryrun=
list=
recurse=
remove=
verbose=

usage() {
  printf "\nUsage: bu2rsync [-lL] [-n] [-r] [-v] directory"
  printf "\nWhere:"
  printf "\n\t-l indicates list the contents of the backup folder"
  printf "\n\t-L indicates recursively list the contents of the backup folder"
  printf "\n\t-n indicates perform a dry run, don't make any changes"
  printf "\n\t-r indicates remove remote backup"
  printf "\n\t-v indicates verbose mode"
  printf "\n\t-u displays this usage message and exits\n"
  exit 1
}

while getopts ":lLnrvu" flag; do
  case $flag in
    l)
      list=1
      ;;
    L)
      list=1
      recurse=1
      ;;
    n)
      dryrun="nv"
      ;;
    r)
      remove=1
      ;;
    v)
      verbose="v"
      ;;
    u)
      usage
      ;;
    \?)
      echo "Invalid option: $flag"
      usage
      ;;
  esac
done
shift $(( OPTIND - 1 ))

[ "$1" ] || {
  printf "\nERROR: directory argument required\n"
  usage
}
[ -d "$1" ] || {
  printf "\nERROR: $1 does not exist or is not a directory\n"
  usage
}

src="$(realpath "$1" | sed -e "s%/$%%")"
name="$(echo "${src}" | sed -e "s%/%_%g" | sed -e "s/^_//")"

if [ "${list}" ]; then
  if [ "${recurse}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -lRa ${myhost}/${name}\n"
    else
      ssh ${user}@${host} ls -lRa "${myhost}/${name}"
    fi
  else
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} ls -la ${myhost}/${name}\n"
    else
      ssh ${user}@${host} ls -la "${myhost}/${name}"
    fi
  fi
else
  if [ "${remove}" ]; then
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} rm -rf${verbose} ${myhost}/${name}\n"
    else
      ssh ${user}@${host} rm -rf${verbose} "${myhost}/${name}"
    fi
  else
    # Create directory if it does not exist
    if [ "${dryrun}" ]; then
      printf "\nssh ${user}@${host} mkdir -p${verbose} ${myhost}\n"
    else
      ssh ${user}@${host} mkdir -p${verbose} ${myhost}
    fi

    # Backup specified directory
    rsync -aHh${dryrun}${verbose} \
      --delete \
      --delete-excluded \
      --exclude='.DS_Store' \
      "${src}/" \
      ${user}@${host}:"${myhost}/${name}"
    [ "${dryrun}" ] || {
      printf "\nListing of rsync.net backup folder ${myhost}/${name}:\n"
      ssh ${user}@${host} ls -a "${myhost}/${name}"
    }
  fi
fi
