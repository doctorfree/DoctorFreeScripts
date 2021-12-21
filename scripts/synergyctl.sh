#!/bin/bash
#
# synergyctl - control Synergy keyboard/mouse sharing client start/stop
#
# Put the synergy server IP here. At boot time name lookup does not work
# and synergyc will fail and exit, using the IP prevents the problem.
SERVER_IP=XX.X.X.XX

# Check locations of Synergy client and system tools
SYNERGYC=/usr/bin/synergyc
[ -x ${SYNERGYC} ] || {
  for synpath in /bin /usr/local/bin /Applications/Synergy.app/Contents/MacOS
  do
    [ -x ${synpath}/synergyc ] && {
      SYNERGYC="${synpath}/synergyc"
      break
    }
  done
}

PS=/bin/ps
[ -x ${PS} ] || {
  for pspath in /sbin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin
  do
    [ -x ${pspath}/ps ] && {
      PS="${pspath}/ps"
      break
    }
  done
}

GREP=/usr/bin/grep
[ -x ${GREP} ] || {
  for grepath in /sbin /usr/sbin /bin /usr/local/sbin /usr/local/bin
  do
    [ -x ${grepath}/grep ] && {
      GREP="${grepath}/grep"
      break
    }
  done
}

WC=/usr/bin/wc
[ -x ${WC} ] || {
  for wcpath in /sbin /usr/sbin /bin /usr/local/sbin /usr/local/bin
  do
    [ -x ${wcpath}/wc ] && {
      WC="${wcpath}/wc"
      break
    }
  done
}

# On a Mac OS X Synergy client, pidof can be installed with Brew
# brew install pidof
PIDOF=/usr/bin/pidof
[ -x ${PIDOF} ] || {
  for pidpath in /sbin /usr/sbin /bin /usr/local/sbin /usr/local/bin
  do
    [ -x ${pidpath}/pidof ] && {
      PIDOF="${pidpath}/pidof"
      break
    }
  done
}

SLEEP=/bin/sleep
[ -x ${SLEEP} ] || {
  for slpath in /sbin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin
  do
    [ -x ${slpath}/sleep ] && {
      SLEEP="${slpath}/sleep"
      break
    }
  done
}

usage() {
    echo "Usage: synergyctl [start|stop]"
    exit 1
}

# check synergyc is running
function sc_check
{
  N=`${PS} -ef | ${GREP} "${SYNERGYC}"  | ${GREP} -v "${GREP}" | ${WC} -l`
  return $N
}

# kill synergyc if running
function sc_kill
{
  SIG=""
  while true
  do
    sc_check
    if [ $? -eq 1 ]
    then
      PIDS=`${PIDOF} "${SYNERGYC}"`
      if [ ${PIDS} != "" ]
      then
        kill ${SIG} ${PIDS}
      fi
    else
      break
    fi

    ${SLEEP} 1
    SIG="-9"
  done
}

# start synergyc
function sc_start
{
  while true
  do
    ${SYNERGYC} "${SERVER_IP}"

    ${SLEEP} 2

    sc_check
    if [ $? -eq 1 ]
    then
      break
    fi
  done
}

COMMAND=${1}
[ "${COMMMAND}" ] || usage

case "${COMMAND}" in
  start)
    sc_kill
    sc_start
  ;;
  stop)
    sc_kill
  ;;
  *)
    usage
  ;;
esac

exit 0
