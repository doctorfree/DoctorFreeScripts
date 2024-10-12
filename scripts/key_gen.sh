#!/bin/bash
#
# key_gen - generate SSH key pair
#
# Usage: key_gen [-e your@email] [-k keyname] [-n] [-u]

def_email="ronaldrecord@gmail.com"
dryrun=
email=
keyname="sshkey_$$"

usage() {
  printf "\nUsage: key_gen [-e your@email] [-k keyname] [-n] [-u]"
  printf "\nWhere:"
  printf "\n\t-e your@email specifies the email address to associate with the key pair"
  printf "\n\t-k keyname specifies the name of the key and filename (without suffix)"
  printf "\n\t-n indicates dry run, display what command would be run"
  printf "\n\t-u displays this usage message and exiit\n"
  exit 1
}

while getopts ":e:k:nu" flag; do
  case $flag in
    e)
      email="$OPTARG"
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

[ "${email}" ] || {
  have_git=$(type -p git)
  [ "${have_git}" ] && {
    email=$(git config -l | grep user.email | awk -F '=' '{ print $2 }')
  }
  [ "${email}" ] || email="${def_email}"
}

have_keygen=$(type -p ssh-keygen)
[ "${have_keygen}" ] || {
  echo "Cannot locate the ssh-keygen tool"
  echo "Install the openssh-client package with 'sudo apt install openssh-client'"
  usage
}

[ -f ~/.ssh/${keyname} ] && {
  echo "A key by this name already exists: ${HOME}/.ssh/${keyname}"
  echo "Remove or use another key name"
  usage
}

if [ "${dryrun}" ]; then
  echo "ssh-keygen -t rsa -b 4096 -C \"${email}\" -f ~/.ssh/${keyname}"
  echo "ssh-keygen -lf ~/.ssh/${keyname}.pub > ~/.ssh/fingerprints/${keyname}.txt"
else
  [ -d ~/.ssh ] || {
    mkdir ~/.ssh
    chmod 700 ~/.ssh
  }
  ssh-keygen -t rsa -b 4096 -C "${email}" -f ~/.ssh/${keyname}
  chmod 600 ~/.ssh/${keyname}
  chmod 644 ~/.ssh/${keyname}.pub
  cat ~/.ssh/${keyname}.pub
  [ -d ~/.ssh/fingerprints ] || {
    mkdir ~/.ssh/fingerprints
    chmod 700 ~/.ssh/fingerprints
  }
  ssh-keygen -lf ~/.ssh/${keyname}.pub > ~/.ssh/fingerprints/${keyname}.txt
  chmod 600 ~/.ssh/fingerprints/${keyname}.txt
fi
