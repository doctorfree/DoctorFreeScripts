#!/bin/bash
#
## @file Wallpapers/setwall.sh
## @brief Set the desktop wallpaper
## @remark Uses AppleScript, OS/X specific
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2015, Ronald Joe Record, all rights reserved.
## @date Written August 30, 2015
## @version 1.0.1
##
#
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

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
   printf "Usage: setwall [-arsu] [-d /path/to/imagedir] [-i image] [-n num]\n"
   printf "\nWhere:\n"
   printf "\t-a specifies set wallpaper on all desktops/displays\n"
   printf "\t-d directory specifies the image directory to use\n"
   printf "\t-i image specifies the image file to use\n"
   printf "\t-n num specifies the desktop number to use\n"
   printf "\t-r rotate through multiple desktop wallpapers\n"
   printf "\t-s single desktop wallpaper (stop rotation)\n"
   printf "\t-u prints this usage message and exits\n\n"
   exit 1
}

## original:
## osascript -e 'tell application "Finder" to set desktop picture to POSIX file
##               "/path/to/picture.jpg"'
##
## example:
## tell application "System Events"
##     set desktopCount to count of desktops
##     repeat with desktopNumber from 1 to desktopCount
##         tell desktop desktopNumber
##             set picture to "/Library/Desktop Pictures/Beach.jpg"
##         end tell
##     end repeat
## end tell
##
## Select display:
##       selected_video_device=$(osascript <<EOF
##           set video_devices to {$video_devs}
##           set video_numbers to {$video_nums}
##           set video_device to (choose from list video_devices with title "AVFoundation Video Devices" with prompt "Select a video device" default items {"$default_video_device"})
##   
##           set video_number to "$default_video_number"
##           if video_device is false then
##               set video_device to "$default_video_device"
##           else
##               set video_number to item (list_position((video_device as string), video_devices)) of video_numbers
##           end if
##           return video_number as string
##   
##           on list_position(this_item, this_list)
##               repeat with i from 1 to count of this_list
##                   if item i of this_list is this_item then return i
##               end repeat
##               return 0
##           end list_position
## EOF)
##       VIDEO=`echo ${selected_video_device} | sed -e "s/\[//" -e "s/\]//"`

rotate_desktop() {
    echo "Rotate desktop wallpapers"
    osascript <<EOF
        tell application "System Events"
            tell current desktop
                set picture rotation to 1
            end tell
        end tell
EOF
}

single_desktop() {
    echo "Use a single desktop wallpaper"
    osascript <<EOF
        tell application "System Events"
            tell current desktop
                set picture rotation to 0
            end tell
        end tell
EOF
}

set_image() {
    image="$1"
    echo "Setting desktop wallpaper to ${image}"
    osascript <<EOF
        tell application "System Events"
            tell current desktop
                set picture rotation to 0
            end tell
        end tell
        tell application "Finder"
            set bgimg to POSIX file "$image" as string
            set desktop picture to file bgimg
        end tell
EOF
}

set_imgdir() {
    directory="$1"
    echo "Setting desktop wallpaper directory to ${directory}"
    osascript <<EOD
        tell application "System Events"
            tell current desktop
                set picture rotation to 1
                set random order to true
            end tell
        end tell
        tell application "Finder"
            set bgdir to POSIX file "$directory" as string
            set picture folder to file bgdir
            set change interval to 5.0 seconds
        end tell
EOD
}

DEFAULT_DIR="${HOME}/Pictures"
DEFAULT_IMG="slope_mountain_peak_rocks_snow_sky_sunset_sunrise_1920x1200.jpg"
DESKTOP=1
DIR=
IMG=
ALL=

while getopts arsd:i:n:u flag; do
   case $flag in
      a)
         ALL=1;
         ;;
      d)
         DIR="$OPTARG";
         ;;
      i)
         IMG="$OPTARG";
         ;;
      n)
         DESKTOP="$OPTARG";
         ;;
      r)
         rotate_desktop
         exit 0
         ;;
      s)
         single_desktop
         exit 0
         ;;
      u)
         usage;
         ;;
   esac
done
shift $(( OPTIND - 1 ));

if [ "${IMG}" ]
then
    if [ "${DIR}" ]
    then
        # Specified both image and image directory
        [ -r "${IMG}" ] || {
            if [ -r "${DIR}"/"${IMG}" ]
            then
                IMG="${DIR}"/"${IMG}"
            else
                echo "Unable to locate image ${IMG} or ${DIR}/${IMG}. Exiting."
                usage
            fi
        }
    else
        # Specified image but not image directory
        if [ -r "${IMG}" ]
        then
            H=`pwd`
            [ -r "${H}"/"${IMG}" ] && IMG="${H}"/"${IMG}"
        else
            if [ -r "${DEFAULT_DIR}"/"${IMG}" ]
            then
                IMG="${DEFAULT_DIR}"/"${IMG}"
            else
                echo "Unable to locate image ${IMG} or ${DEFAULT_DIR}/${IMG}."
                echo "Exiting."
                usage
            fi
        fi
    fi
    set_image "${IMG}"
else
    # Specified image directory but not image
    if [ "${DIR}" ]
    then
        set_imgdir "${DIR}"
    else
        set_image "${DEFAULT_DIR}"/"${DEFAULT_IMG}"
    fi
fi

