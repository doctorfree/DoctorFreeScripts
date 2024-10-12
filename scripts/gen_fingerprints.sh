#!/bin/bash
#
# gen_fingerprints - generate public key fingerprints from ~/.ssh/*.pub
#
# Usage: gen_fingerprints [-a] [-f] [-k keyname] [-n] [-u]

dryrun=
keyname=

usage() {
  printf "\nUsage: gen_fingerprints [-a] [-f] [-k keyname] [-n] [-u]"
  printf "\nWhere:"
  printf "\n\t-a indicates generate fingerprints for all public keys in ~/.ssh"
  printf "\n\t-f indicates overwrite any existing fingerprint"
  printf "\n\t-k keyname specifies the name of the key and filename (without suffix)"
  printf "\n\t-n indicates dry run, display what command would be run"
  printf "\n\t-u displays this usage message and exiit\n"
  exit 1
}

gen_print() {
  key="$1"
  [ -f ~/.ssh/fingerprints/${key}.txt ] && {
    [ "${force}" ] || {
      echo "~/.ssh/fingerprints/${key}.txt already exists. Skipping."
      return
    }
  }
  if [ "${dryrun}" ]; then
    echo "ssh-keygen -lf ~/.ssh/${key}.pub > ~/.ssh/fingerprints/${key}.txt"
  else
    [ -d ~/.ssh/fingerprints ] || {
      mkdir ~/.ssh/fingerprints
      chmod 700 ~/.ssh/fingerprints
    }
    ssh-keygen -lf ~/.ssh/${key}.pub > ~/.ssh/fingerprints/${key}.txt
    chmod 600 ~/.ssh/fingerprints/${key}.txt
  fi
}

all=
force=
while getopts ":afk:nu" flag; do
  case $flag in
    a)
      all=1
      ;;
    f)
      force=1
      ;;
    k)
      keyname="$OPTARG"
      ;;
    n)
      dryrun=1
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

have_keygen=$(type -p ssh-keygen)
[ "${have_keygen}" ] || {
  echo "Cannot locate the ssh-keygen tool"
  echo "Install the openssh-client package with 'sudo apt install openssh-client'"
  usage
}

if [ "${keyname}" ]; then
  keyname=$(echo ${keyname} | sed -e "s/\.pub$//")
  [ -f ~/.ssh/${keyname}.pub ] || {
    echo "ERROR: cannot locate ${HOME}/.ssh/${keyname}.pub"
    usage
  }
  gen_print ${keyname}
else
  if [ "${all}" ]; then
    for k in ~/.ssh/*.pub
    do
      keyn=$(basename $k | sed -e "s/\.pub$//")
      gen_print ${keyn}
    done
  else
    echo "No key specified. Use -a to specify all public keys."
    usage
  fi
fi
