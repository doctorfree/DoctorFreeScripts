#!/bin/bash
#
## @file IFTTT/ifttt.sh
## @brief Send a text message to my IFTTT phone channel with a trigger tag
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2017, Ronald Joe Record, all rights reserved.
## @date Written 29-Jan-2017
## @version 1.0.1
##
#
# My IFTTT Phone Channel number
# (Replace ########## with your IFTTT phone number)
IFT="##########"
MSG=

usage() {
    printf "\nUsage: ifttt [lights | appletv | bluray | tv | off] [on | off]"
    printf "\n\tFirst argument required. Second argument optional, default on"
    printf "\n\nExample invocations:"
    printf "\n\tTurn all lights on"
    printf "\n\t\tifttt lights on     -or-    ifttt lights"
    printf "\n\tTurn all lights off"
    printf "\n\t\tifttt lights off"
    printf "\n\tTurn Apple TV on"
    printf "\n\t\tifttt appletv on    -or-    ifttt appletv"
    printf "\n\tTurn Apple TV off"
    printf "\n\t\tifttt appletv off"
    printf "\n\tTurn Blu-Ray player on"
    printf "\n\t\tifttt bluray on     -or-    ifttt bluray"
    printf "\n\tTurn Blu-Ray player off"
    printf "\n\t\tifttt bluray off"
    printf "\n\tTurn TV on"
    printf "\n\t\tifttt tv on         -or-    ifttt tv"
    printf "\n\tTurn TV off"
    printf "\n\t\tifttt tv off\n"
    exit 1
}

[ "$1" ] || usage
[ "$1" = "-u" ] && usage

inst=`type -p osascript`
[ "$inst" ] || {
    echo "AppleScript is not supported on this platform."
    echo "Unable to send text message via command line."
    usage
}

# Convert arguments to lower case
activity=`echo "$1" | tr '[:upper:]' '[:lower:]'`
action=`echo "$2" | tr '[:upper:]' '[:lower:]'`

[ "$activity" = "lights" ] && {
    [ "$action" = "on" ] && MSG="#LightsOn"
    [ "$action" = "off" ] && MSG="#LightsOff"
    [ "$action" = "spin" ] && MSG="#Spin"
    [ "$action" ] || MSG="#LightsOn"
}

[ "$activity" = "appletv" ] && {
    [ "$action" = "on" ] && MSG="#AppleTV"
    [ "$action" = "off" ] && MSG="#AppleOff"
    [ "$action" ] || MSG="#AppleTV"
}

[ "$activity" = "bluray" ] && {
    [ "$action" = "on" ] && MSG="#Bluray"
    [ "$action" = "off" ] && MSG="#BlurayOff"
    [ "$action" ] || MSG="#Bluray"
}

[ "$activity" = "tv" ] && {
    [ "$action" = "on" ] && MSG="#WatchTV"
    [ "$action" = "off" ] && MSG="#Off"
    [ "$action" ] || MSG="#WatchTV"
}

[ "$activity" = "off" ] && {
    MSG="#Goodnight"
}

[ "$MSG" ] || usage

osascript << EOT
tell application "Messages"
  send "$MSG" to buddy "$IFT" of service "SMS"
end tell
EOT

[ "$activity" = "off" ] && {
    sleep 5
    MSG="#Bedtime"
    osascript << EOT
tell application "Messages"
  send "$MSG" to buddy "$IFT" of service "SMS"
end tell
EOT
}
