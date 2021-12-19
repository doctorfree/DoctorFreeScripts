#!/bin/bash
#
# synergyctl - control Synergy keyboard/mouse sharing client start/stop
#
# Put the synergy server IP here (at boot time name lookup does not work
# and synergyc will fail and exit, using the IP prevents the problem)
SERVER_IP=XX.X.X.XX

SYNERGYC=/usr/bin/synergyc
PS=/bin/ps
GREP=/bin/grep
WC=/usr/bin/wc
PIDOF=/sbin/pidof
SLEEP=/bin/sleep

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
