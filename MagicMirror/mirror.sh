#!/bin/bash
#
## @file mirror.sh
## @brief Convenience script to manage multiple MagicMirror configurations
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2020, Ronald Joe Record, all rights reserved.
## @date Written 1-feb-2020
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
# Set this to your MagicMirror installation directory
MM="${HOME}/MagicMirror"
# Set the IP and PORT to the values on your system
# IP is the IP address of your MagicMirror Raspberry Pi
IP="10.0.1.85"
# PORT is the port your MMM-Remote-Control module is running on
PORT="8080"
#
# Set you MMM-Remote-Control API Key here or leave blank if you have not configured one
#
# Replace "MMM-Remote-Control_API_Key" with your MMM-Remote-Control API Key
apikey="MMM-Remote-Control_API_Key"
# Uncomment this line if you have not configured an MMM-Remote-Control API Key
# apikey=
#
# Set this to the X11 DISPLAY you are using. DISPLAY=:0 works for most systems.
export DISPLAY=:0
# -----------------------------------------------------------------------
CONFDIR="${MM}/config"
SLISDIR="${MM}/modules/MMM-BackgroundSlideshow/pics"
WHVNDIR="Pictures/Seagate_8TB/Work/Wallhaven"
CONFS=
BACKS=
INFO="all"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
usejq=`type -p jq`

[ "${apikey}" == "MMM-Remote-Control_API_Key" ] && {
    printf "\nMMM-Remote-Control API Key is not configured. Either add your key"
    printf "\nor comment out the empty setting for 'apikey' near the beginning of this script."
    printf "\n\nContinuing but some functionality disabled.\n"
}

[ -d "${CONFDIR}" ] || {
    printf "\nCONFDIR does not exist or is not a directory. Exiting.\n"
    exit 1
}
cd "${CONFDIR}"

check_config() {
    if [ "$1" == "all" ]
    then
        current=`ls -l config.js | awk ' { print $11 } '`
        echo "Saving $current MagicMirror configuration"
        for config in config-*.js
        do
            [ "$config" == "config-*.js" ] && {
                echo "No MagicMirror configuration files config-*.js found in $CONFDIR"
                continue
            }
            rm -f config.js
            ln -s ${config} config.js
            echo "Checking ${config} ..."
            npm run --silent config:check
            echo "Done"
        done
        echo "Restoring $current MagicMirror configuration"
        rm -f config.js
        if [ -f ${current} ]
        then
            ln -s ${current} config.js
        else
            echo "Config file ${current} does not exist. Using default."
            ln -s config-default.js config.js
        fi
    else
        if [ -L config.js ] && [ -f config.js ]
        then
            npm run --silent config:check
        else
            if [ -f config.js ]
            then
                npm run --silent config:check
            else
                echo "Config file config.js is a broken symbolic link. Removing."
                rm -f config.js
                echo "Installing default config file, config-default.js"
                ln -s config-default.js config.js
            fi
        fi
    fi
}

display_status() {
    vcgencmd display_power | grep  -q 'display_power=1' && \
        echo 'Display ON' || echo 'Display OFF'
}

getconfs() {
    numconfs=0
    for i in config-*.js
    do
        j=`echo $i | awk -F "-" ' { print $2 } ' | sed -e "s/.js//"`
        CONFS="${CONFS} $j"
        [ "$1" == "usage" ] && {
            numconfs=`expr $numconfs + 1`
            [ $numconfs -gt 8 ] && {
                CONFS="${CONFS}\n\t"
                numconfs=0
            }
        }
    done
}

list_mods() {
    [ "$1" ] || {
        printf "\nArgument of 'active', 'installed', or 'configs' required to list modules."
        list_usage
    }
    if [ "$1" == "active" ]
    then
        printf "\n${BOLD}Listing Active MagicMirror modules${NORMAL}\n"
        if [ "$usejq" ]
        then
          if [ "${apikey}" ]
          then
            curl -X GET http://${IP}:${PORT}/api/modules?apiKey=${apikey} 2> /dev/null | jq .
          else
            curl -X GET http://${IP}:${PORT}/api/modules 2> /dev/null | jq .
          fi
        else
          if [ "${apikey}" ]
          then
            curl -X GET http://${IP}:${PORT}/api/modules?apiKey=${apikey}
          else
            curl -X GET http://${IP}:${PORT}/api/modules
          fi
          echo ""
        fi
    else
        if [ "$1" == "installed" ]
        then
            printf "\n${BOLD}Listing Installed MagicMirror modules${NORMAL}\n"
            if [ "$usejq" ]
            then
              if [ "${apikey}" ]
              then
                curl -X GET http://${IP}:${PORT}/api/modules/installed?apiKey=${apikey} 2> /dev/null | jq .
              else
                curl -X GET http://${IP}:${PORT}/api/modules/installed 2> /dev/null | jq .
              fi
            else
              if [ "${apikey}" ]
              then
                curl -X GET http://${IP}:${PORT}/api/modules/installed?apiKey=${apikey}
              else
                curl -X GET http://${IP}:${PORT}/api/modules/installed
              fi
              echo ""
            fi
        else
            if [ "$1" == "configs" ]
            then
                printf "\n${BOLD}Listing MagicMirror configuration files:${NORMAL}\n\n"
                ls config-*.js
                [ -d Models ] && {
                  printf "\n${BOLD}Listing MagicMirror Models configuration files:${NORMAL}\n\n"
                  ls Models/config-*.js
                }
                [ -d JAV ] && {
                  printf "\n${BOLD}Listing MagicMirror JAV configuration files:${NORMAL}\n\n"
                  ls JAV/config-*.js
                }
            else
                printf "\nmirror list $1 is not an accepted 2nd argument."
                printf "\nValid 2nd arguments to the list command are 'active', 'installed', and 'configs'"
                list_usage
            fi
        fi
    fi
}

rotate_screen() {
    [ "$1" == "left" ] || [ "$1" == "normal" ] || [ "$1" == "right" ] || {
        printf "\nUsage: rotate option takes an argument of 'left', 'right', or 'normal'"
        printf "\n Exiting.\n"
        usage
    }
    printf "\n${BOLD}Rotating screen display $1 ${NORMAL}\n"
    xrandr --output HDMI-1 --rotate $1
    printf "\n${BOLD}Done${NORMAL}\n"
}

screen_control() {
    if [ "$1" ]
    then
      if [ "$1" == "on" ]
      then
        vcgencmd display_power 1 > /dev/null
      else
        if [ "$1" == "off" ]
        then
          vcgencmd display_power 0 > /dev/null
        else
          if [ "$1" == "status" ] || [ "$1" == "info" ]
          then
            mirror info screen
          else
            usage
          fi
        fi
      fi
    else
      mirror info screen
    fi
}

start_dev() {
    printf "\n${BOLD}Starting MagicMirror in developer mode${NORMAL}\n"
    cd "${MM}"
    pm2 stop MagicMirror --update-env
    npm start dev
    printf "\n${BOLD}Done${NORMAL}\n"
}

get_brightness() {
    printf "\n${BOLD}Getting MagicMirror Brightness Level${NORMAL}\n"
    if [ "$usejq" ]
    then
      if [ "${apikey}" ]
      then
        curl -X GET http://${IP}:${PORT}/api/brightness?apiKey=${apikey} 2> /dev/null | jq .
      else
        curl -X GET http://${IP}:${PORT}/api/brightness 2> /dev/null | jq .
      fi
    else
      if [ "${apikey}" ]
      then
        curl -X GET http://${IP}:${PORT}/api/brightness?apiKey=${apikey}
      else
        curl -X GET http://${IP}:${PORT}/api/brightness
      fi
      echo ""
    fi
}

set_brightness() {
    [ "$1" ] || {
        printf "\nNumeric argument required to specify Mirror brightness.\n"
        setb_usage
    }
    if [ "$1" -ge 0 ] && [ "$1" -le 200 ]
    then
        printf "\n${BOLD}Setting MagicMirror Brightness Level to $1${NORMAL}\n"
        if [ "$usejq" ]
        then
          if [ "${apikey}" ]
          then
            curl -X GET http://${IP}:${PORT}/api/brightness/$1?apiKey=${apikey} 2> /dev/null | jq .
          else
            curl -X GET http://${IP}:${PORT}/api/brightness/$1 2> /dev/null | jq .
          fi
        else
          if [ "${apikey}" ]
          then
            curl -X GET http://${IP}:${PORT}/api/brightness/$1?apiKey=${apikey}
          else
            curl -X GET http://${IP}:${PORT}/api/brightness/$1
          fi
          echo ""
        fi
    else
        printf "\nBrightness setting $1 out of range or not a number"
        printf "\nValid brightness values are integer values [0-200]\n"
        setb_usage
    fi
}

wh_create() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    if [ -d "${HOME}/${WHVNDIR}/${PICDIR}" ]
    then
        printf "\nCreating config file for ${WHVNDIR}/${PICDIR}"
        [ -d "${SLISDIR}/${PICDIR}" ] || mkdir -p "${SLISDIR}/${PICDIR}"
        cd "${SLISDIR}/${PICDIR}"
        rm -f *.jpg
        ln -s ../../../../../${WHVNDIR}/${PICDIR}/*.jpg .
        haveim=`type -p identify`
        if [ "$haveim" ]
        then
          # Remove photos in landscape mode for vertical mirror
          for i in *.jpg
          do
            [ "$i" == "*.jpg" ] && {
                printf "\nNo JPEG pics found in ${WHVNDIR}/${PICDIR} ... Exiting\n"
                cd ..
                rm -rf "${PICDIR}"
                usage
            }
            GEO=`identify "$i" 2> /dev/null | awk ' { print $(NF-6) } '`
            W=`echo $GEO | awk -F "x" ' { print $1 } '`
            # Remove if width not greater than 750
            [ "$W" ] && [ $W -gt 750 ] || {
                rm -f "$i"
                continue
            }
            H=`echo $GEO | awk -F "x" ' { print $2 } '`
            # Remove if height not greater than 1000
            [ "$H" ] && [ $H -gt 1000 ] || {
                rm -f "$i"
                continue
            }
            # Remove if height not greater than width
            [ "$W" ] && [ "$H" ] && [ $H -gt $W ] || rm -f "$i"
          done
        else
          printf "\nCould not find identify command. Install ImageMagick"
          printf "\nSkipping removal of landscape photos\n"
        fi
        cd "${CONFDIR}"
        [ -f "config-${PICDIR}.js" ] || {
            cat config-wh-template.js | sed -e "s/WH_DIR_HOLDER/${PICDIR}/" > "config-${PICDIR}.js"
        }
        mirror ${PICDIR}
    else
        printf "\nFolder argument ${WHVNDIR}/${PICDIR} does not exist or is not a directory."
        usage
    fi
}

wh_remove() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    [ -d "${SLISDIR}/${PICDIR}" ] && {
        printf "\nRemoving config file and pic folder for ${WHVNDIR}/${PICDIR}"
        cd "${SLISDIR}"
        rm -rf "${PICDIR}"
    }
    rm -f "${CONFDIR}/config-${PICDIR}.js"
    mirror default
}

usage() {
    getconfs usage
    printf "\n${BOLD}Usage:${NORMAL} mirror <command> [args]"
    printf "\nWhere <command> can be one of the following:"
    printf "\n\tinfo [temp|mem|disk|usb|net|wireless|screen],"
    printf " list <active|installed|configs>, rotate [right|left|normal],"
    printf " models_dir, select, restart, screen [on|off|info|status], start, stop,"
    printf " status [all], dev, getb, setb <num>, wh <dir>, whrm <dir>"
    printf "\nor specify a config file to use with one of:"
    printf "\n\t${CONFS}"
    printf "\nor any other config file you have created in ${CONFDIR} of the form:"
    printf "\n\tconfig-<name>.js"
    printf "\nA config filename argument will be resolved into a config filename of the form:"
    printf "\n\tconfig-\$argument.js"
    printf "\n\nArguments can also be specified as follows:"
    printf "\n\t-b <brightness>, -B, -c <config>, -d, -i <info>, -I, -l <list>,"
    printf "\n\t-r <rotate>, -s <screen>, -S, -w <dir>, -W <dir>, -u"
    printf "\n\n${BOLD}Examples:${NORMAL}"
    printf "\n\tmirror\t\t# Invoked with no arguments the mirror command displays a command menu"
    printf "\n\tmirror list active\t\t# lists active modules"
    printf "\n\tmirror list configs\t\t# lists available configuration files"
    printf "\n\tmirror restart\t\t# Restart MagicMirror"
    printf "\n\tmirror fractals\t\t# Installs configuration file config-fractals.js"
    printf " and restarts MagicMirror"
    printf "\n\tmirror info\t\t# Displays all MagicMirror system information"
    printf "\n\tmirror info screen\t\t# Displays MagicMirror screen information"
    printf "\n\tmirror dev\t\t# Restarts the mirror in developer mode"
    printf "\n\tmirror rotate left/right/normal\t\t# rotates the screen left, right, or normal"
    printf "\n\tmirror screen on\t\t#  Turns the Display ON"
    printf "\n\tmirror screen off\t\t# Turns the Display OFF"
    printf "\n\tmirror status [all]\t\t# Displays MagicMirror status, checks config syntax"
    printf "\n\tmirror getb\t\t# Displays current MagicMirror brightness level"
    printf "\n\tmirror setb 150\t\t# Sets MagicMirror brightness level to 150"
    printf "\n\tmirror wh foobar\t\t# Creates and activates a slideshow config with pics in foobar"
    printf "\n\tmirror whrm foobar\t\t# Deactivate and remove slideshow in foobar"
    printf "\n\tmirror -u\t\t# Display this usage message\n"
    exit 1
}

list_usage() {
    printf "\n${BOLD}List Usage:${NORMAL} mirror list <active|installed|configs>"
    printf "\nWhere 'active', 'installed', or 'configs' must be specified."
    printf "\nThis command will list either all active or installed modules or all configs.\n"
    usage
}

setb_usage() {
    printf "\n${BOLD}Setb Usage:${NORMAL} mirror setb [number]"
    printf "\nWhere 'number' is an integer value in the range 0-200\n"
    usage
}

setconf() {
    conf=$1
    subdir=$2
    if [ -f config.js ]
    then
        mv config.js config-$$.js
    else
        rm -f config.js
    fi
    if [ "$subdir" ]
    then
        ln -s $subdir/config-${conf}.js config.js
    else
        ln -s config-${conf}.js config.js
    fi
    npm run --silent config:check > /dev/null
    [ $? -eq 0 ] || {
        if [ "$subdir" ]
        then
            printf "\nMagicMirror configuration $subdir/config-${conf}.js needs work."
        else
            printf "\nMagicMirror configuration config-${conf}.js needs work."
        fi
        printf "\nTry again after you have addressed these issues:\n"
        npm run --silent config:check
        rm -f config.js
        [ -f config-$$.js ] && mv config-$$.js config.js
        exit 1
    }
    [ -L config-$$.js ] && rm -f config-$$.js
    pm2 restart MagicMirror --update-env
}

set_config() {
    mode="$1"
    subdir="$2"
    echo $mode | grep / > /dev/null && {
        subdir=`dirname $mode`
        mode=`basename $mode`
    }
    [ "$mode" == "waterfall" ] && mode="waterfalls"
    [ "$mode" == "fractal" ] && mode="fractals"

    cd "${CONFDIR}"
    if [ -f config-${mode}.js ]
    then
        setconf ${mode}
    else
        if [ -f ${subdir}/config-${mode}.js ]
        then
            setconf ${mode} ${subdir}
        else
            if [ "${subdir}" ]
            then
                printf "\nNo configuration file ${subdir}/config-${mode}.js found.\n\n"
            else
                printf "\nNo configuration file config-${mode}.js found.\n\n"
            fi
            usage
        fi
    fi
}

system_info() {
    printf "\n${BOLD}System information for:${NORMAL}\n"
    uname -a
    [ "$INFO" == "all" ] || [ "$INFO" == "temp" ] && {
        printf "\nCPU `vcgencmd measure_temp`\n"
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "mem" ] && {
        cpu_mem=`vcgencmd get_mem arm | awk -F "=" ' { print $2 } '`
        gpu_mem=`vcgencmd get_mem gpu | awk -F "=" ' { print $2 } '`
        printf "\n${BOLD}Memory Split:${NORMAL}\tCPU=${cpu_mem}\tGPU=${gpu_mem}\n"
        printf "\n${BOLD}Memory:${NORMAL}\n"
        free -h
    }
    [ "$INFO" == "all" ] || [ "$INFO" == "disk" ] && {
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
        printf "${BOLD}Screen dimensions and resolution:${NORMAL}\n"
        xrandr | grep Screen
        xdpyinfo | grep dimensions
        xdpyinfo | grep resolution
        display_status
    }
}

get_info_type() {
    PS3="${BOLD}Please enter desired system info type (numeric or text): ${NORMAL}"
    options=(all temp mem disk usb net wireless screen quit back)
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "back",*|*,"back")
                break
                ;;
            "quit",*|*,"quit")
                exit 0
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
                printf "\nEnter either a number or text of one of the menu entries\n"
                ;;
        esac
    done
}

# If invoked with no arguments present a menu of options to select from
[ "$1" ] || {
  while true
  do
    PS3="${BOLD}Please enter your MagicMirror command choice (numeric or text): ${NORMAL}"
    options=("dev" "list active modules" "list installed modules" "list configurations" "select configuration" "rotate left" "rotate normal" "rotate right" "restart" "screen off" "screen on" "start" "stop" "status" "status all" "get brightness" "set brightness" "system info" "quit")
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "dev",*|*,"dev")
                mirror dev
                break
                ;;
            "list active modules",*|*,"list active modules")
                mirror list active
                break
                ;;
            "list installed modules",*|*,"list installed modules")
                mirror list installed
                break
                ;;
            "list configurations",*|*,"list configurations")
                printf "\n======================================================\n"
                mirror list configs
                printf "\n======================================================\n"
                break
                ;;
            "select configuration",*|*,"select configuration")
                printf "======================================================\n\n"
                mirror select
                break
                ;;
            "get brightness",*|*,"get brightness")
                mirror getb
                break
                ;;
            "set brightness",*|*,"set brightness")
                while true
                do
                  read -p "Enter a brightness level between 0 and 200 or 'exit' to quit" answer
                  [ "$answer" == "exit" ] && break
                  if [ $answer -ge 0 ] && [ $answer -le 200 ]
                  then
                      printf "\nSetting MagicMirror Brightness Level to $answer\n"
                      if [ "$usejq" ]
                      then
                        if [ "${apikey}" ]
                        then
                          curl -X GET http://${IP}:${PORT}/api/brightness/$answer?apiKey=${apikey} 2> /dev/null | jq .
                        else
                          curl -X GET http://${IP}:${PORT}/api/brightness/$answer 2> /dev/null | jq .
                        fi
                      else
                        if [ "${apikey}" ]
                        then
                          curl -X GET http://${IP}:${PORT}/api/brightness/$answer?apiKey=${apikey}
                        else
                          curl -X GET http://${IP}:${PORT}/api/brightness/$answer
                        fi
                        echo ""
                      fi
                  else
                      printf "\nBrightness setting $answer out of range or not a number"
                      printf "\nValid brightness values are integer values [0-200]\n"
                  fi
                done
                break
                ;;
            "screen *",*|*,"screen *")
                mirror ${opt}
                break
                ;;
            "system info",*|*,"system info")
                get_info_type
                break
                ;;
            "start",*|*,"start")
                mirror start
                break
                ;;
            "stop",*|*,"stop")
                mirror stop
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
            "rotate *",*|*,"rotate *")
                mirror ${opt}
                break
                ;;
            "restart",*|*,"restart")
                mirror restart
                break
                ;;
            "quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
        esac
    done
  done
}

# TODO: getopt processing for these remaining commands
# select
# restart
# start
# stop
# status [all]

while getopts b:Bc:di:Il:r:s:Sw:W:u flag; do
    case $flag in
        b)
          set_brightness ${OPTARG}
          ;;
        B)
          get_brightness
          ;;
        c)
          set_config ${OPTARG}
          ;;
        d)
          start_dev
          ;;
        I)
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
        l)
            case ${OPTARG} in
              active|installed|configs)
                list_mods ${OPTARG}
                ;;
              *)
                list_usage
                ;;
            esac
            ;;
        r)
          rotate_screen ${OPTARG}
          ;;
        S)
          screen_control
          ;;
        s)
          screen_control ${OPTARG}
          ;;
        w)
          wh_create ${OPTARG}
          ;;
        W)
          wh_remove ${OPTARG}
          ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$1" == "models_dir" ] && {
  if [ -d "${SLISDIR}/backgrounds" ]
  then
    cd "${SLISDIR}/backgrounds"
    for i in *
    do
        [ "$i" == "*" ] && continue
        BACKS="${BACKS} $i"
    done

    cd "${CONFDIR}"
    PS3="${BOLD}Enter your MagicMirror model choice (numeric or text): ${NORMAL}"
    options=(ALL ${BACKS} Jenya quit)
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
            "ALL",*|*,"ALL")
                if [ -f config-Models.js ]
                then
                    printf "\nInstalling config-Models.js MagicMirror configuration file\n"
                    setconf Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Ali_Rose",*|*,"Ali_Rose")
                if [ -f config-ali_rose.js ]
                then
                    printf "\nInstalling config-ali_rose.js MagicMirror configuration file\n"
                    setconf ali_rose Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Alisa_I",*|*,"Alisa_I")
                if [ -f config-alisa_i.js ]
                then
                    printf "\nInstalling config-alisa_i.js MagicMirror configuration file\n"
                    setconf alisa_i Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Carisha",*|*,"Carisha")
                if [ -f config-carisha.js ]
                then
                    printf "\nInstalling config-carisha.js MagicMirror configuration file\n"
                    setconf carisha Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Corinna",*|*,"Corinna")
                if [ -f config-corinna.js ]
                then
                    printf "\nInstalling config-corinna.js MagicMirror configuration file\n"
                    setconf corinna Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "David_Dubnitskiy",*|*,"David_Dubnitskiy")
                if [ -f config-david.js ]
                then
                    printf "\nInstalling config-david.js MagicMirror configuration file\n"
                    setconf david Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Dmitry_Borisov",*|*,"Dmitry_Borisov")
                if [ -f config-dmitry.js ]
                then
                    printf "\nInstalling config-dmitry.js MagicMirror configuration file\n"
                    setconf dmitry Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Heidi_Romanova",*|*,"Heidi_Romanova")
                if [ -f config-heidi.js ]
                then
                    printf "\nInstalling config-heidi.js MagicMirror configuration file\n"
                    setconf heidi Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Helly_von_Valentine",*|*,"Helly_von_Valentine")
                if [ -f config-helly.js ]
                then
                    printf "\nInstalling config-helly.js MagicMirror configuration file\n"
                    setconf helly Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Igor_Viushkin",*|*,"Igor_Viushkin")
                if [ -f config-igor.js ]
                then
                    printf "\nInstalling config-igor.js MagicMirror configuration file\n"
                    setconf igor Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Jenya",*|*,"Jenya")
                if [ -f config-jenya.js ]
                then
                    printf "\nInstalling config-jenya.js MagicMirror configuration file\n"
                    setconf jenya Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Li_Moon",*|*,"Li_Moon")
                if [ -f config-li_moon.js ]
                then
                    printf "\nInstalling config-li_moon.js MagicMirror configuration file\n"
                    setconf li_moon Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Martina_Mink",*|*,"Martina_Mink")
                if [ -f config-martina.js ]
                then
                    printf "\nInstalling config-martina.js MagicMirror configuration file\n"
                    setconf martina Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Nata_Lee",*|*,"Nata_Lee")
                if [ -f config-nata.js ]
                then
                    printf "\nInstalling config-nata.js MagicMirror configuration file\n"
                    setconf nata Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Natalia_Andreeva",*|*,"Natalia_Andreeva")
                if [ -f config-natalia.js ]
                then
                    printf "\nInstalling config-natalia.js MagicMirror configuration file\n"
                    setconf natalia Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Stefan_Soell",*|*,"Stefan_Soell")
                if [ -f config-stefan.js ]
                then
                    printf "\nInstalling config-stefan.js MagicMirror configuration file\n"
                    setconf stefan Models
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            *)
                if [ -f config-${opt}.js ]
                then
                    printf "\nInstalling config-${opt}.js MagicMirror configuration file\n"
                    setconf ${opt} Models
                    break
                else
                    if [ -f config-${REPLY}.js ]
                    then
                        printf "\nInstalling config-${REPLY}.js MagicMirror configuration file\n"
                        setconf ${REPLY} Models
                        break
                    else
                        printf "\nInvalid entry. Please try again"
                        printf "\nEnter either a number or text of one of the menu entries\n"
                    fi
                fi
                ;;
        esac
    done
    exit 0
  else
    echo "${SLISDIR}/backgrounds does not exist or is not a directory. Skipping."
  fi
}

[ "$1" == "jav_idols" ] && {
  if [ -d "${SLISDIR}/jav" ]
  then
    cd "${SLISDIR}/jav"
    for i in *
    do
        [ "$i" == "*" ] && continue
        JAVS="${JAVS} $i"
    done

    cd "${CONFDIR}"
    PS3="${BOLD}Enter your MagicMirror JAV Idol choice (numeric or text): ${NORMAL}"
    options=(ALL ${JAVS} quit)
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
            "ALL",*|*,"ALL")
                if [ -f config-JAV.js ]
                then
                    printf "\nInstalling config-JAV.js MagicMirror configuration file\n"
                    setconf JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Aika_Yumeno",*|*,"Aika_Yumeno")
                if [ -f JAV/config-aika.js ]
                then
                    printf "\nInstalling JAV/config-aika.js MagicMirror configuration file\n"
                    setconf aika JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Airi_Suzumura",*|*,"Airi_Suzumura")
                if [ -f JAV/config-airi.js ]
                then
                    printf "\nInstalling JAV/config-airi.js MagicMirror configuration file\n"
                    setconf airi JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Aoi",*|*,"Aoi")
                if [ -f JAV/config-aoi.js ]
                then
                    printf "\nInstalling JAV/config-aoi.js MagicMirror configuration file\n"
                    setconf aoi JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Asuna_Kawai",*|*,"Asuna_Kawai")
                if [ -f JAV/config-asuna.js ]
                then
                    printf "\nInstalling JAV/config-asuna.js MagicMirror configuration file\n"
                    setconf asuna JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Julia_Kyoka",*|*,"Julia_Kyoka")
                if [ -f JAV/config-julia.js ]
                then
                    printf "\nInstalling JAV/config-julia.js MagicMirror configuration file\n"
                    setconf julia JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Kana_Momonogi",*|*,"Kana_Momonogi")
                if [ -f JAV/config-kana.js ]
                then
                    printf "\nInstalling JAV/config-kana.js MagicMirror configuration file\n"
                    setconf kana JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Mana_Sakura",*|*,"Mana_Sakura")
                if [ -f JAV/config-mana.js ]
                then
                    printf "\nInstalling JAV/config-mana.js MagicMirror configuration file\n"
                    setconf mana JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Masami_Ichikawa",*|*,"Masami_Ichikawa")
                if [ -f JAV/config-masami.js ]
                then
                    printf "\nInstalling JAV/config-masami.js MagicMirror configuration file\n"
                    setconf masami JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Matsuri_Kiritani",*|*,"Matsuri_Kiritani")
                if [ -f JAV/config-matsuri.js ]
                then
                    printf "\nInstalling JAV/config-matsuri.js MagicMirror configuration file\n"
                    setconf matsuri JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Mayuki_Ito",*|*,"Mayuki_Ito")
                if [ -f JAV/config-mayuki.js ]
                then
                    printf "\nInstalling JAV/config-mayuki.js MagicMirror configuration file\n"
                    setconf mayuki JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Miharu_Usa",*|*,"Miharu_Usa")
                if [ -f JAV/config-miharu.js ]
                then
                    printf "\nInstalling JAV/config-miharu.js MagicMirror configuration file\n"
                    setconf miharu JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Minami_Hatsukawa",*|*,"Minami_Hatsukawa")
                if [ -f JAV/config-minami.js ]
                then
                    printf "\nInstalling JAV/config-minami.js MagicMirror configuration file\n"
                    setconf minami JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Minami_Kojima",*|*,"Minami_Kojima")
                if [ -f JAV/config-minami2.js ]
                then
                    printf "\nInstalling JAV/config-minami2.js MagicMirror configuration file\n"
                    setconf minami2 JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Moe_Amatsuka",*|*,"Moe_Amatsuka")
                if [ -f JAV/config-moe.js ]
                then
                    printf "\nInstalling JAV/config-moe.js MagicMirror configuration file\n"
                    setconf moe JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Momo_Sakura",*|*,"Momo_Sakura")
                if [ -f JAV/config-momo.js ]
                then
                    printf "\nInstalling JAV/config-momo.js MagicMirror configuration file\n"
                    setconf momo JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Nodoka_Sakuraha",*|*,"Nodoka_Sakuraha")
                if [ -f JAV/config-nodoka.js ]
                then
                    printf "\nInstalling JAV/config-nodoka.js MagicMirror configuration file\n"
                    setconf nodoka JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Shoko_Takahashi",*|*,"Shoko_Takahashi")
                if [ -f JAV/config-shoko.js ]
                then
                    printf "\nInstalling JAV/config-shoko.js MagicMirror configuration file\n"
                    setconf shoko JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Suzu_Honjo",*|*,"Suzu_Honjo")
                if [ -f JAV/config-suzu.js ]
                then
                    printf "\nInstalling JAV/config-suzu.js MagicMirror configuration file\n"
                    setconf suzu JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Syunka_Ayami",*|*,"Syunka_Ayami")
                if [ -f JAV/config-syunka.js ]
                then
                    printf "\nInstalling JAV/config-syunka.js MagicMirror configuration file\n"
                    setconf syunka JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Utsunomiya_Shion",*|*,"Utsunomiya_Shion")
                if [ -f JAV/config-utsunomiya.js ]
                then
                    printf "\nInstalling JAV/config-utsunomiya.js MagicMirror configuration file\n"
                    setconf utsunomiya JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Yua_Mikami",*|*,"Yua_Mikami")
                if [ -f JAV/config-yua.js ]
                then
                    printf "\nInstalling JAV/config-yua.js MagicMirror configuration file\n"
                    setconf yua JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Yuna_Ogura",*|*,"Yuna_Ogura")
                if [ -f JAV/config-yuna.js ]
                then
                    printf "\nInstalling JAV/config-yuna.js MagicMirror configuration file\n"
                    setconf yuna JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            "Yura_Kano",*|*,"Yura_Kano")
                if [ -f JAV/config-yura.js ]
                then
                    printf "\nInstalling JAV/config-yura.js MagicMirror configuration file\n"
                    setconf yura JAV
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            *)
                if [ -f JAV/config-${opt}.js ]
                then
                    printf "\nInstalling JAV/config-${opt}.js MagicMirror configuration file\n"
                    setconf ${opt} JAV
                    break
                else
                    if [ -f JAV/config-${REPLY}.js ]
                    then
                        printf "\nInstalling JAV/config-${REPLY}.js MagicMirror configuration file\n"
                        setconf ${REPLY} JAV
                        break
                    else
                        printf "\nInvalid entry. Please try again"
                        printf "\nEnter either a number or text of one of the menu entries\n"
                    fi
                fi
                ;;
        esac
    done
    exit 0
  else
    echo "${SLISDIR}/backgrounds does not exist or is not a directory. Skipping."
  fi
}

[ "$1" == "select" ] && {
    getconfs select
    PS3="${BOLD}Please enter your MagicMirror configuration choice (numeric or text): ${NORMAL}"
    options=(${CONFS} quit)
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
            "JAV",*|*,"JAV")
                printf "======================================================\n\n"
                mirror jav_idols
                break
                ;;
            "Models",*|*,"Models")
                printf "======================================================\n\n"
                mirror models_dir
                break
                ;;
            *)
                if [ -f config-${opt}.js ]
                then
                    printf "\nInstalling config-${opt}.js MagicMirror configuration file\n"
                    setconf ${opt}
                    break
                else
                    if [ -f config-${REPLY}.js ]
                    then
                        printf "\nInstalling config-${REPLY}.js MagicMirror configuration file\n"
                        setconf ${REPLY}
                        break
                    else
                        printf "\nInvalid entry. Please try again"
                        printf "\nEnter either a number or text of one of the menu entries\n"
                    fi
                fi
                ;;
        esac
    done
    exit 0
}

[ "$1" == "dev" ] && {
    start_dev
    exit 0
}

[ "$1" == "info" ] && {
    [ "$2" ] && INFO="$2"
    system_info
    exit 0
}

[ "$1" == "screen" ] && {
    screen_control $2
    exit 0
}

[ "$1" == "restart" ] && {
    printf "\n${BOLD}Restarting MagicMirror${NORMAL}\n"
    pm2 restart MagicMirror --update-env
    printf "\n${BOLD}Done${NORMAL}\n"
    exit 0
}

[ "$1" == "rotate" ] && {
    rotate_screen $2
    exit 0
}

[ "$1" == "start" ] && {
    printf "\n${BOLD}Starting MagicMirror${NORMAL}\n"
    pm2 start MagicMirror --update-env
    printf "\n${BOLD}Done${NORMAL}\n"
    exit 0
}

[ "$1" == "stop" ] && {
    printf "\n${BOLD}Stopping MagicMirror${NORMAL}\n"
    pm2 stop MagicMirror --update-env
    printf "\n${BOLD}Done${NORMAL}\n"
    exit 0
}

[ "$1" == "status" ] && {
    printf "\n${BOLD}MagicMirror Status:${NORMAL}\n"
    pm2 status MagicMirror --update-env
    CONF=`readlink -f ${CONFDIR}/config.js`
    printf "\nUsing config file `basename ${CONF}`\n"
    display_status
    check_config $2
    printf "\n${BOLD}Done${NORMAL}\n"
    exit 0
}

[ "$1" == "getb" ] && {
    get_brightness
    exit 0
}

[ "$1" == "list" ] && {
    list_mods $2
    exit 0
}

[ "$1" == "setb" ] && {
    set_brightness $2
    exit 0
}

[ "$1" == "wh" ] && {
    wh_create $2
    exit 0
}

[ "$1" == "whrm" ] && {
    wh_remove $2
    exit 0
}

[ "$1" ] && set_config $1
exit 0
