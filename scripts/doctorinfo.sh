#!/bin/bash
#
## @file doctorinfo.sh
## @brief Convenience script to retrieve a wide variety of system info
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2022, Ronald Joe Record, all rights reserved.
## @date Written 12-Jan-2022
## @version 1.0.0
##
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#
# User configurable settings. Make sure these are correct for your system.
# -----------------------------------------------------------------------
# Set the IP and PORT to the values on your system
# IP is the IP address of your MagicMirror Raspberry Pi or 'localhost'
IP="MM.M.M.MM"
MCL_HOME="/usr/local/MirrorCommand"
[ -d ${MCL_HOME}/bin ] && {
    export PATH=${PATH}:${MCL_HOME}/bin
}

fake_vcgencmd=
have_vcgencmd=`type -p vcgencmd`
[ "${have_vcgencmd}" == "${MCL_HOME}/bin/vcgencmd" ] && fake_vcgencmd=1

# Set this to the X11 DISPLAY you are using. DISPLAY=:0 works for most systems.
export DISPLAY=${DISPLAY:=:0}

MIRRORSCREEN="${MCL_HOME}/etc/mirrorscreen"
HAVE_PORT=
[ -f ${MIRRORSCREEN} ] || MIRRORSCREEN="${MM}/.mirrorscreen"
[ -f ${MIRRORSCREEN} ] && {
  . ${MIRRORSCREEN}
  screen=SCREEN_${MM_SCREEN}[mode]
  [ ${!screen+_} ] && {
    PORTRAIT=${!screen}
    HAVE_PORT=1
  }
}
[ "${HAVE_PORT}" ] || {
  PORTRAIT=1
  SCREEN_RES=`xdpyinfo | awk '/dimensions/ {print $2}'`
  echo ${SCREEN_RES} | grep x > /dev/null && {
    SCREEN_WIDTH=`echo ${SCREEN_RES} | awk -F 'x' ' { print $1 } '`
    SCREEN_HEIGHT=`echo ${SCREEN_RES} | awk -F 'x' ' { print $2 } '`
  }
  if ! [[ "$SCREEN_WIDTH" =~ ^[0-9]+$ ]]
  then
    SCREEN_WIDTH=`xrandr | grep current | awk -F ',' ' { print $2 } ' | awk ' { print $2 } '`
  fi
  if ! [[ "$SCREEN_HEIGHT" =~ ^[0-9]+$ ]]
  then
    SCREEN_HEIGHT=`xrandr | grep current | awk -F ',' ' { print $2 } ' | awk ' { print $4 } '`
  fi
  [ ${SCREEN_WIDTH} -gt ${SCREEN_HEIGHT} ] && PORTRAIT=
}

device=SCREEN_${MM_SCREEN}[hdmi]
if [ ${!device+_} ]
then
  HDMI=${!device}
else
  HDMI=`xrandr --listactivemonitors | grep ${MM_SCREEN}: | awk ' { print $4 } '`
fi

# -----------------------------------------------------------------------
PLEASE="Please enter your"
NUMPROMPT="Enter either a number or text of one of the menu entries"
SUBDIR_CONFS=
START_DEV=
TELEGRAM=
ERROR_EXIT=1
INFO="all"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
usejq=`type -p jq`

display_status() {
    vcgencmd display_power | egrep 'display_power=1|On' > /dev/null && \
        echo 'Display ON' || echo 'Display OFF'
}

usage() {
    printf "\n${BOLD}Usage:${NORMAL} doctorinfo [-a] [-i system] [-u] <command> [args]"
    printf "\nWhere <system> can be one of the following:"
    printf "\n    <temp|mem|disk|usb|net|wireless|screen>"
    printf "\n\t-a indicates report info on all systems"
    printf "\n\t-u indicates display usage message\n"
    exit ${ERROR_EXIT}
}

system_info() {
    printf "\n${BOLD}System information for:${NORMAL}\n"
    HNAM=`uname -n`
    OSVR=`uname -s -r`
    printf "${HNAM} running ${OSVR}\n"
    [ "$INFO" == "all" ] || [ "$INFO" == "temp" ] && {
        if [ "${fake_vcgencmd}" ]
        then
            printf "\nSystem temperatures:\n`vcgencmd measure_temp`\n"
        else
            printf "\nCPU `vcgencmd measure_temp`\n"
        fi
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "mem" ] && {
        if [ "${fake_vcgencmd}" ]
        then
            vcgencmd get_mem
        else
            cpu_mem=`vcgencmd get_mem arm | awk -F "=" ' { print $2 } '`
            gpu_mem=`vcgencmd get_mem gpu | awk -F "=" ' { print $2 } '`
            printf "\n${BOLD}Memory Split:${NORMAL}\tCPU=${cpu_mem}\tGPU=${gpu_mem}\n"
            printf "\n${BOLD}Memory:${NORMAL}\n"
        fi
        free -h

        printf "\n${BOLD}Motherboard/Memory info:${NORMAL}\n"
        sudo dmidecode -t 2
        printf "\n${BOLD}RAM slots:${NORMAL}\n"
        sudo lshw -class memory 
        printf "\n${BOLD}Maximum supportable memory:${NORMAL}\n"
        sudo dmidecode -t memory
        printf "\n"
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "disk" ] && {
        printf "\n${BOLD}Disks and partitions:${NORMAL}\n"
        sudo lsblk -e7
        printf "\n"
        printf "\n${BOLD}Disk and filesystem usage:${NORMAL}\n"
        findmnt --fstab --evaluate
        printf "\n"
        df -h -x tmpfs -x udev -x devtmpfs
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "usb" ] && {
        printf "\n${BOLD}USB Devices:${NORMAL}\n"
        lsusb
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "net" ] && {
        printf "\n${BOLD}Network IP/mask:${NORMAL}\n"
        ifconfig | grep inet | grep netmask
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "wireless" ] && {
        printf "\n${BOLD}Wireless info:${NORMAL}\n"
        iwconfig 2> /dev/null | grep ESSID | while read entry
        do
            interface=`echo $entry | awk ' { print $1 } '`
            iwconfig $interface
        done
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "screen" ] && {
        printf "\n${BOLD}Screen dimensions and resolution:${NORMAL}\n"
        xrandr --query --verbose | grep Screen
        xdpyinfo | grep dimensions
        xdpyinfo | grep resolution
        display_status
        printf "\n${BOLD}Connected monitors:${NORMAL}\n"
        xrandr --query --verbose | grep connected | grep -v disconnected
        printf "\n${BOLD}MirrorCommand configured screens:${NORMAL}"
        printf "\n\tNumber of screens = ${NUMSCREENS}"
        device=SCREEN_${MM_SCREEN}[hdmi]
        if [ ${!device+_} ]
        then
          hdmi=${!device}
        else
          hdmi=`xrandr --listactivemonitors | grep ${MM_SCREEN}: | awk ' { print $4 } '`
        fi
        printf "\n\tCurrent display screen device = ${hdmi}"
        dispnum=${MM_SCREEN}
        ((dispnum+=1))
        printf "\n\t\tUse screen number ${dispnum} to address this screen"
        xoff=SCREEN_${MM_SCREEN}[xoff]
        yoff=SCREEN_${MM_SCREEN}[yoff]
        [ ${!xoff+_} ] && [ ${!yoff+_} ] && {
          printf "\n\t\tX Offset = ${!xoff}, and Y Offset = ${!yoff}"
        }
        [ "${NUMSCREENS}" ] && [ ${NUMSCREENS} -gt 1 ] && {
          [ ${dispnum} -ge ${NUMSCREENS} ] && dispnum=0
          device=SCREEN_${dispnum}[hdmi]
          if [ ${!device+_} ]
          then
            hdmi=${!device}
          else
            hdmi=`xrandr --listactivemonitors | grep ${dispnum}: | awk ' { print $4 } '`
          fi
          printf "\n\tAlternate display screen device = ${hdmi}"
          xoff=SCREEN_${dispnum}[xoff]
          yoff=SCREEN_${dispnum}[yoff]
          ((dispnum+=1))
          printf "\n\t\tUse screen number ${dispnum} to address this screen"
          [ ${!xoff+_} ] && [ ${!yoff+_} ] && {
            printf "\n\t\tX Offset = ${!xoff}, and Y Offset = ${!yoff}"
          }
        }
        printf "\n"
    }
}

get_info_type() {
    PS3="${BOLD}Please enter desired system info type (numeric or text): ${NORMAL}"
    options=(all temp mem disk usb net wireless screen "Main menu" "Quit")
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "Main menu",*|*,"Main menu"|"Back",*|*,"Back"|"back",*|*,"back")
                break
                ;;
            "Quit",*|*,"Quit"|"quit",*|*,"quit")
                return 9
                ;;
            "all",*|*,"all")
                INFO="all"
                system_info
                break
                ;;
            "temp",*|*,"temp")
                INFO="temp"
                system_info
                break
                ;;
            "mem",*|*,"mem")
                INFO="mem"
                system_info
                break
                ;;
            "disk",*|*,"disk")
                INFO="disk"
                system_info
                break
                ;;
            "usb",*|*,"usb")
                INFO="usb"
                system_info
                break
                ;;
            "net",*|*,"net")
                INFO="net"
                system_info
                break
                ;;
            "wireless",*|*,"wireless")
                INFO="wireless"
                system_info
                break
                ;;
            "screen",*|*,"screen")
                INFO="screen"
                system_info
                break
                ;;
            *)
                printf "\nInvalid entry. Please try again"
                printf "\n${NUMPROMPT}\n"
                ;;
        esac
    done
    return 0
}

# If invoked with no arguments present a menu of options to select from
[ "$1" ] || {
  while true
  do
    PS3="${BOLD}${PLEASE} command choice (numeric or text): ${NORMAL}"
    options=("status" "status all" "system info" "quit")
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "screen *",*|*,"screen *")
            doctorinfo ${opt}
                break
                ;;
            "system info",*|*,"system info")
                get_info_type
                [ $? -eq 9 ] && exit 0
                break
                ;;
            "status",*|*,"status")
                mirror status
                break
                ;;
            "status all",*|*,"status all")
                mirror status all
                break
                ;;
            "Quit",*|*,"Quit"|"quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
        esac
    done
  done
}

while getopts ai:u flag; do
    case $flag in
        a)
            INFO="all"
            system_info
            ;;
        i)
            case ${OPTARG} in
              all|temp|mem|disk|usb|net|wireless|screen)
                INFO=${OPTARG}
                system_info
                ;;
              *)
                usage
                ;;
            esac
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$1" == "info" ] && {
    [ "$2" ] && INFO="$2"
    system_info
    exit 0
}

[ "$1" == "screen" ] && {
    INFO="screen"
    system_info
    exit 0
}

exit 0
