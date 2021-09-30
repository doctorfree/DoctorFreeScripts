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
ARTISTDIR="Pictures/Artists-ALL"
MODELDIR="Pictures/Models-ALL"
PHOTODIR="Pictures/Photographers-ALL"
ARTIST_TEMPLATE="${CONFDIR}/Templates/config-artist-template.js"
MODEL_TEMPLATE="${CONFDIR}/Templates/config-model-template.js"
PHOTO_TEMPLATE="${CONFDIR}/Templates/config-photo-template.js"
WHVNDIR="Pictures/Wallhaven"
WH_TEMPLATE="Templates/config-wh-template.js"
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
                [ -d Photographers ] && {
                  printf "\n${BOLD}Listing MagicMirror Photographers configuration files:${NORMAL}\n\n"
                  ls Photographers/config-*.js
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

model_create() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    # Create a configuration file for this model if one does not exist
    printf "\nCreating config file ${CONFDIR}/Models/config-${PICDIR}.js\n"
    cd "${CONFDIR}/Models"
    [ -f "config-${PICDIR}.js" ] || {
        if [ -f ${MODEL_TEMPLATE} ]
        then
            cat ${MODEL_TEMPLATE} | sed -e "s/MODEL_DIR_HOLDER/${PICDIR}/" > "config-${PICDIR}.js"
        else
            echo "Model config template $MODEL_TEMPLATE not found"
            exit 1
        fi
    }
    if [ -d "${HOME}/Pictures/Models/${PICDIR}" ]
    then
        # Already have a prepared folder for this model
        printf "\nUsing existing model folder pics\n"
        setconf ${PICDIR} Models
    else
      if [ -d "${HOME}/${MODELDIR}/${PICDIR}" ]
      then
        printf "\nCreating image folder for ${SLISDIR}/Models/${PICDIR}\n"
        [ -d "${SLISDIR}/Models/${PICDIR}" ] || mkdir -p "${SLISDIR}/Models/${PICDIR}"
        cd "${SLISDIR}/Models/${PICDIR}"
        rm -f *.jpg
        cp -L ${HOME}/${MODELDIR}/${PICDIR}/*.jpg .
        cd "${CONFDIR}"
        setconf ${PICDIR} Models
      else
        printf "\nFolder argument ${MODELDIR}/${PICDIR} does not exist or is not a directory."
        usage
      fi
    fi
}

model_remove() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    [ -d "${SLISDIR}/${PICDIR}" ] && {
        printf "\nRemoving config file and pic folder for ${MODELDIR}/${PICDIR}"
        cd "${SLISDIR}"
        rm -rf "${PICDIR}"
    }
    rm -f "${CONFDIR}/Models/config-${PICDIR}.js"
    mirror default
}

artist_create() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    printf "\nCreating config file ${CONFDIR}/Artists/config-${PICDIR}.js\n"
    cd "${CONFDIR}/Artists"
    [ -f "config-${PICDIR}.js" ] || {
        if [ -f ${ARTIST_TEMPLATE} ]
        then
            cat ${ARTIST_TEMPLATE} | sed -e "s/ARTIST_DIR_HOLDER/${PICDIR}/" > "config-${PICDIR}.js"
        else
            echo "Artist config template $ARTIST_TEMPLATE not found"
            exit 1
        fi
    }
    if [ -d "${HOME}/Pictures/Artists/${PICDIR}" ]
    then
        # Already have a prepared folder for this artist
        printf "\nUsing existing ${PICDIR} image folder\n"
        setconf ${PICDIR} Artists
    else
      if [ -d "${HOME}/${ARTISTDIR}/${PICDIR}" ]
      then
        printf "\nCreating image folder ${SLISDIR}/Artists/${PICDIR}\n"
        [ -d "${SLISDIR}/Artists/${PICDIR}" ] || mkdir -p "${SLISDIR}/Artists/${PICDIR}"
        cd "${SLISDIR}/Artists/${PICDIR}"
        rm -f *.jpg
        cp -L ${HOME}/${ARTISTDIR}/${PICDIR}/*.jpg .
        cd "${CONFDIR}"
        setconf ${PICDIR} Artists
      else
        printf "\nFolder argument ${ARTISTDIR}/${PICDIR} does not exist or is not a directory."
        usage
      fi
    fi
}

artist_remove() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    [ -d "${SLISDIR}/${PICDIR}" ] && {
        printf "\nRemoving config file and pic folder for ${ARTISTDIR}/${PICDIR}"
        cd "${SLISDIR}"
        rm -rf "${PICDIR}"
    }
    rm -f "${CONFDIR}/Artists/config-${PICDIR}.js"
    mirror default
}

photo_create() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    printf "\nCreating config file ${CONFDIR}/Photographers/config-${PICDIR}.js\n"
    cd "${CONFDIR}/Photographers"
    [ -f "config-${PICDIR}.js" ] || {
        if [ -f ${PHOTO_TEMPLATE} ]
        then
            cat ${PHOTO_TEMPLATE} | sed -e "s/PHOTO_DIR_HOLDER/${PICDIR}/" > "config-${PICDIR}.js"
        else
            echo "Photographer config template $PHOTO_TEMPLATE not found"
            exit 1
        fi
    }
    if [ -d "${HOME}/Pictures/Photographers/${PICDIR}" ]
    then
        # Already have a prepared folder for this photographer
        printf "\nUsing existing ${PICDIR} image folder\n"
        setconf ${PICDIR} Photographers
    else
      if [ -d "${HOME}/${PHOTODIR}/${PICDIR}" ]
      then
        printf "\nCreating image folder ${SLISDIR}/Photographers/${PICDIR}\n"
        [ -d "${SLISDIR}/Photographers/${PICDIR}" ] || mkdir -p "${SLISDIR}/Photographers/${PICDIR}"
        cd "${SLISDIR}/Photographers/${PICDIR}"
        rm -f *.jpg
        cp -L ${HOME}/${PHOTODIR}/${PICDIR}/*.jpg .
        cd "${CONFDIR}"
        setconf ${PICDIR} Photographers
      else
        printf "\nFolder argument ${PHOTODIR}/${PICDIR} does not exist or is not a directory."
        usage
      fi
    fi
}

photo_remove() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    [ -d "${SLISDIR}/${PICDIR}" ] && {
        printf "\nRemoving config file and pic folder for ${PHOTODIR}/${PICDIR}"
        cd "${SLISDIR}"
        rm -rf "${PICDIR}"
    }
    rm -f "${CONFDIR}/Photographers/config-${PICDIR}.js"
    mirror default
}

wh_create() {
    [ "$1" ] || {
        printf "\nFolder argument required to specify Slideshow dir.\n"
        usage
    }
    PICDIR="$1"
    cd "${CONFDIR}"
    printf "\nCreating config file ${CONFDIR}/config-${PICDIR}.js\n"
    [ -f "config-${PICDIR}.js" ] || {
        if [ -f ${WH_TEMPLATE} ]
        then
            cat ${WH_TEMPLATE} | sed -e "s/WH_DIR_HOLDER/${PICDIR}/" > "config-${PICDIR}.js"
        else
            echo "Wallhaven config template $WH_TEMPLATE not found"
            exit 1
        fi
    }
    if [ -d "${HOME}/${WHVNDIR}/${PICDIR}" ]
    then
        printf "\nCreating image folder ${SLISDIR}/${PICDIR}"
        [ -d "${SLISDIR}/${PICDIR}" ] || mkdir -p "${SLISDIR}/${PICDIR}"
        cd "${SLISDIR}/${PICDIR}"
        rm -f *.jpg
        cp -L ${HOME}/${WHVNDIR}/${PICDIR}/*.jpg .
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
    printf " models_dir, photogs_dir, select, restart, screen [on|off|info|status], start, stop,"
    printf " status [all], dev, getb, setb <num>, ac <artist>, ar <artist>, mc <model>,"
    printf " mr <model>, pc <photographer>, pr <photographer>, wh <dir>, whrm <dir>"
    printf "\n\nor specify a config file to use with one of:"
    printf "\n\t${CONFS}"
    printf "\n\nor any other config file you have created in ${CONFDIR} of the form:"
    printf "\n\tconfig-<name>.js"
    printf "\n\nA config filename argument will be resolved into a config filename of the form:"
    printf "\n\tconfig-\$argument.js"
    printf "\n\nArguments can also be specified as follows:"
    printf "\n\t-a <artist>, -A <artist>, -b <brightness>, -B, -c <config>, -d, -i <info>,"
    printf "\n\t-I, -l <list>, -r <rotate>, -s <screen>, -S, -m <model>, -M <model>,"
    printf "\n\t-p <photographer>, -P <photographer>, -w <dir>, -W <dir>, -u"
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
    cd "${CONFDIR}"
    if [ -f config.js ]
    then
        mv config.js config-$$.js
    else
        rm -f config.js
    fi
    if [ "$subdir" ]
    then
        echo "Setting MagicMirror configuration to ${subdir}/config-${conf}.js"
        ln -s $subdir/config-${conf}.js config.js
    else
        echo "Setting MagicMirror configuration to config-${conf}.js"
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
    mode=`echo $mode | sed -e "s/\.js$//" -e "s/^config-//"`
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

while getopts a:A:b:Bc:di:Il:m:M:p:P:r:s:Sw:W:u flag; do
    case $flag in
        a)
          artist_create ${OPTARG}
          ;;
        A)
          artist_remove ${OPTARG}
          ;;
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
        m)
          model_create ${OPTARG}
          ;;
        M)
          model_remove ${OPTARG}
          ;;
        p)
          photo_create ${OPTARG}
          ;;
        P)
          photo_remove ${OPTARG}
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
  if [ -d "${SLISDIR}/Models" ]
  then
    cd "${SLISDIR}/Models"
    for i in *
    do
        [ "$i" == "*" ] && continue
        BACKS="${BACKS} $i"
    done

    cd "${CONFDIR}"
    PS3="${BOLD}Enter your MagicMirror model choice (numeric or text): ${NORMAL}"
    options=(ALL ${BACKS} quit)
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
            *)
                if [ -f Models/config-${opt}.js ]
                then
                    printf "\nInstalling config-${opt}.js MagicMirror configuration file\n"
                    setconf ${opt} Models
                    break
                else
                    if [ -f Models/config-${REPLY}.js ]
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
    echo "${SLISDIR}/Models does not exist or is not a directory. Skipping."
  fi
}

[ "$1" == "photogs_dir" ] && {
  if [ -d "${SLISDIR}/Photographers" ]
  then
    cd "${SLISDIR}/Photographers"
    for i in *
    do
        [ "$i" == "*" ] && continue
        PHOTS="${PHOTS} $i"
    done

    cd "${CONFDIR}"
    PS3="${BOLD}Enter your MagicMirror photographer choice (numeric or text): ${NORMAL}"
    options=(ALL ${PHOTS} quit)
    select opt in "${options[@]}"
    do
        case "$opt,$REPLY" in
            "quit",*|*,"quit")
                printf "\nExiting\n"
                exit 0
                ;;
            "ALL",*|*,"ALL")
                if [ -f config-Photographers.js ]
                then
                    printf "\nInstalling config-Photographers.js MagicMirror configuration file\n"
                    setconf Photographers
                    break
                else
                    printf "\nInvalid entry. Please try again"
                    printf "\nEnter either a number or text of one of the menu entries\n"
                fi
                ;;
            *)
                if [ -f Photographers/config-${opt}.js ]
                then
                    printf "\nInstalling config-${opt}.js MagicMirror configuration file\n"
                    setconf ${opt} Photographers
                    break
                else
                    if [ -f Photographers/config-${REPLY}.js ]
                    then
                        printf "\nInstalling config-${REPLY}.js MagicMirror configuration file\n"
                        setconf ${REPLY} Photographers
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
    echo "${SLISDIR}/Models does not exist or is not a directory. Skipping."
  fi
}

[ "$1" == "jav_idols" ] && {
  if [ -d "${SLISDIR}/JAV" ]
  then
    cd "${SLISDIR}/JAV"
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
    echo "${SLISDIR}/JAV does not exist or is not a directory. Skipping."
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
            "Photographers",*|*,"Photographers")
                printf "======================================================\n\n"
                mirror photogs_dir
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

[ "$1" == "ac" ] && {
    artist_create $2
    exit 0
}

[ "$1" == "ar" ] && {
    artist_remove $2
    exit 0
}

[ "$1" == "mc" ] && {
    model_create $2
    exit 0
}

[ "$1" == "mr" ] && {
    model_remove $2
    exit 0
}

[ "$1" == "pc" ] && {
    photo_create $2
    exit 0
}

[ "$1" == "pr" ] && {
    photo_remove $2
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
