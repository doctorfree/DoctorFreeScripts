#!/bin/bash
#
## @file cap2any.sh
## @brief Capture the screen and output to the specified audio/video format
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2015, Ronald Joe Record, all rights reserved.
## @date Written 6-Jul-2015
## @version 1.0.1
##
## See https://trac.ffmpeg.org/wiki/Capture/Desktop
##
## Use the avfoundation device:
##
## ffmpeg -f avfoundation -list_devices true -i ""
##
## This will enumerate all the available input devices including
## screens ready to be captured. Once you've figured out the device
## index corresponding to the screen to be captured use:
##
## ffmpeg -f avfoundation -i "<scr device index>:<aud device index>" out.m4v
##
## This will capture the screen from <screen device index> and audio from
## <audio device index> into the output file out.m4v.
##
## Uses the default options for audio/video encoding from my any2any script
##
##    This program works by either linking or copying cap2any to a file
##    which specifies the desired output format by its name.
##    Alternately, the -o command line option can be used to specify
##    the output file format.
##
##    For example, if you want to capture to MP4 then you could
##    create a symbolic link from cap2any to cap2mp4 as follows:
##        ln -s cap2any cap2mp4
##    Similarly, symbolic links (or copies or hard links) could be created to
##    capture to any other audio/video format.
##
##    Naming restricton: cap2[3 lowercase letter output]
##    for a 7 letter name beginning with "cap2". The 3 letter prefix and
##    suffix must also be a filename suffix that ffmpeg recognizes as a valid
##    audio/video format.
##
##    For example, the following are filenames that conform to this restriction:
##        cap2mp4 cap2mpg cap2mkv cap2m4a cap2wmv
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
## AVFoundation supports the following options:
## 
## -list_devices <TRUE|FALSE>
##    If set to true, a list of all available input devices is given showing
##    all device names and indices.
## -video_device_index <INDEX>
##    Specify the video device by its index. Overrides anything given in the
##    input filename.
## -audio_device_index <INDEX>
##    Specify the audio device by its index. Overrides anything given in the
##    input filename.
## -pixel_format <FORMAT>
##    Request the video device to use a specific pixel format. If the specified
##    format is not supported a list of available formats is given and the first
##    one in this list is used instead. Available pixel formats are: monob,
##    rgb555be, rgb555le, rgb565be, rgb565le, rgb24, bgr24, 0rgb, bgr0, 0bgr,
##    rgb0, bgr48be, uyvy422, yuva444p, yuva444p16le, yuv444p, yuv422p16,
##    yuv422p10, yuv444p10, yuv420p, nv12, yuyv422, gray
## 
## Examples
## 
## Print the list of AVFoundation supported devices and exit:
## $ ffmpeg -f avfoundation -list_devices true -i ""
## 
## Record video from video device 0 and audio from audio device 0 into out.avi:
## $ ffmpeg -f avfoundation -i "0:0" out.avi
## 
## Record video from video device 2 and audio from audio device 1 into out.avi:
## $ ffmpeg -f avfoundation -video_device_index 2 -i ":1" out.avi
## 
## Record video from the system default video device using the pixel format bgr0
## and do not record any audio into out.avi:
## $ ffmpeg -f avfoundation -pixel_format bgr0 -i "default:none" out.avi
## 

## @fn GetVideoNum()
## @brief Lists devices and retrieves video device index
## @param none
##
## Uses AppleScript, if available, to provide graphical user interface
GetVideoNum() {
    video_devs=
    video_nums=
    ${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep -v "devices:" | egrep -i "Video|Camera|Screen" | awk ' { for(i=6;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}' > /tmp/__avout$$
    while read line
    do
        devnam=`echo $line | awk ' { for(i=2;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS } '`
        devnum=`echo $line | awk ' { print $1 } '`
        if [ "$video_devs" ]
        then
            video_devs="$video_devs, \"$devnam\""
            video_nums="$video_nums, \"$devnum\""
            video_dev_names=("${video_dev_names[@]}" "$devnam")
            video_dev_numbs=("${video_dev_numbs[@]}" "$devnum")
        else
            video_devs="\"$devnam\""
            video_nums="\"$devnum\""
            video_dev_names=("$devnam")
            video_dev_numbs=("$devnum")
        fi
    done < /tmp/__avout$$
    video_devs="$video_devs, \"default\", \"none\""
    video_nums="$video_nums, \"default\", \"none\""
    video_dev_names=("${video_dev_names[@]}" "default" "none")
    video_dev_numbs=("${video_dev_numbs[@]}" "default" "none")

    if [ "$APPLE_SCRIPT" ]
    then
        selected_video_device=$(osascript <<EOF
            set video_devices to {$video_devs}
            set video_numbers to {$video_nums}
            set video_device to (choose from list video_devices with title "AVFoundation Video Devices" with prompt "Select a video device" default items {"$default_video_device"})
    
            set video_number to "$default_video_number"
            if video_device is false then
                set video_device to "$default_video_device"
            else
                set video_number to item (list_position((video_device as string), video_devices)) of video_numbers
            end if
            return video_number as string
    
            on list_position(this_item, this_list)
                repeat with i from 1 to count of this_list
                    if item i of this_list is this_item then return i
                end repeat
                return 0
            end list_position
EOF)
        VIDEO=`echo ${selected_video_device} | sed -e "s/\[//" -e "s/\]//"`
    else
        # Use the Bash select statement to get user device selection
        video_num_size=${#video_dev_numbs[@]}
        printf '\nSelect the video device you wish to capture:\n\n'
        PS3='Video device number? '
        select device in "${video_dev_names[@]}"
        do
            if ([ $REPLY -gt 0 ] && [ $REPLY -le $video_num_size ])
            then
                video_index=`expr $REPLY - 1`
                video_device=${video_dev_numbs[$video_index]}
                VIDEO=`echo ${video_device} | sed -e "s/\[//" -e "s/\]//"`
                break
            else
                printf "Unexpected reply: $REPLY"
            fi
        done
    fi
}

## @fn GetAudeoNum()
## @brief Lists devices and retrieves audio device index
## @param none
##
## Uses AppleScript, if available, to provide graphical user interface
GetAudioNum() {
    audio_devs=
    audio_nums=
    ${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep -v "devices:" | egrep -i "Audio|Sound|Microphone" | awk ' { for(i=6;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}' > /tmp/__avout$$
    while read line
    do
        devnam=`echo $line | awk ' { for(i=2;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS } '`
        devnum=`echo $line | awk ' { print $1 } '`
        if [ "$audio_devs" ]
        then
            audio_devs="$audio_devs, \"$devnam\""
            audio_nums="$audio_nums, \"$devnum\""
            audio_dev_names=("${audio_dev_names[@]}" "$devnam")
            audio_dev_numbs=("${audio_dev_numbs[@]}" "$devnum")
        else
            audio_devs="\"$devnam\""
            audio_nums="\"$devnum\""
            audio_dev_names=("$devnam")
            audio_dev_numbs=("$devnum")
        fi
    done < /tmp/__avout$$
    audio_devs="$audio_devs, \"default\", \"none\""
    audio_nums="$audio_nums, \"default\", \"none\""
    audio_dev_names=("${audio_dev_names[@]}" "default" "none")
    audio_dev_numbs=("${audio_dev_numbs[@]}" "default" "none")

    if [ "$APPLE_SCRIPT" ]
    then
        selected_audio_device=$(osascript <<EOF
            set audio_devices to {$audio_devs}
            set audio_numbers to {$audio_nums}
            set audio_device to (choose from list audio_devices with title "AVFoundation Audio Devices" with prompt "Select an audio device" default items {"$default_audio_device"})
    
            if audio_device is false then
                set audio_device to "$default_audio_device"
                set audio_number to "$default_audio_number"
            else
                set audio_number to item (list_position((audio_device as string), audio_devices)) of audio_numbers
            end if
            return audio_number as string
    
            on list_position(this_item, this_list)
                repeat with i from 1 to count of this_list
                    if item i of this_list is this_item then return i
                end repeat
                return 0
            end list_position
EOF)
        AUDIO=`echo ${selected_audio_device} | sed -e "s/\[//" -e "s/\]//"`
    else
        # Use the Bash select statement to get user device selection
        audio_num_size=${#audio_dev_numbs[@]}
        printf '\nSelect the audio device you wish to capture:\n\n'
        PS3='Audio device number? '
        select device in "${audio_dev_names[@]}"
        do
            if ([ $REPLY -gt 0 ] && [ $REPLY -le $audio_num_size ])
            then
                audio_index=`expr $REPLY - 1`
                audio_device=${audio_dev_numbs[$audio_index]}
                AUDIO=`echo ${audio_device} | sed -e "s/\[//" -e "s/\]//"`
                break
            else
                printf "Unexpected reply: $REPLY"
            fi
        done
    fi
}

# I put the latest experimental ffmpeg in /usr/local/bin but if it's not there
# simply revert to whatever is first in our PATH
FFMPEG=/usr/local/bin/ffmpeg
[ -x ${FFMPEG} ] || FFMPEG=ffmpeg
prompt_video=1
prompt_audio=1
default_audio_device=`${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep Built | grep Microphone | head -1 | awk ' { for(i=7;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
default_audio_number=`${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep Built | grep Microphone | head -1 | awk ' {print $6}'`
default_video_device=`${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep Capture | grep screen | head -1 | awk ' { for(i=7;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
default_video_number=`${FFMPEG} -f avfoundation -list_devices true -i "" 2>&1 | grep AVFoundation | grep Capture | grep screen | head -1 | awk ' { print $6 }'`

ME=`basename $0`
if [ "$ME" = "cap2any" ]
then
    SUF="mp4"
    DIR="MP4"
else
    SUF="${ME:4:3}"
    DIR=`echo $SUF | tr '[:lower:]' '[:upper:]'`
fi

CODEC=
SIZE=
OVER=
TELL=
USAGE=
ACODEC=
VCODEC=
OUT_PRE=
PRESET=
QSCALE=
RATE=
ASAMPLE=
VSAMPLE=
CHARACTER=
APPLE_SCRIPT=
THREAD=
ITUNES=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
  printf "\nUsage: $ME [-a audio codec] [-v video codec] [-c codec] [-p preset]"
  printf "\n\t\t[-V screen device index] [-A audio device index]"
  printf "\n\t\t[-o output format (lower case)] [-O output filename no suffix]"
  printf "\n\t\t[-q scale] [-r rate] [-b audio bitrate] [-z video bitrate]"
  printf "\n\t\t[-s size] [-t threads] [-I] [-C] [-d] [-D] [-y] [-u]"
  printf "\n\nWhere:\n\t-d indicates tell me what you would do"
  printf "\n\t-C indicates use the character interface, ignore AppleScript"
  printf "\n\t-D indicates use default audio and video devices, don't prompt"
  printf "\n\t-o output format specifies the 3 letter lower case output format"
  printf "\n\t-O output filename specifies the output filename without suffix"
  printf "\n\t-a audio codec specifies the output audio codec"
  printf "\n\t-v video codec specifies the output video codec"
  printf "\n\t-s size specifies the output video size (widthxheight)"
  printf "\n\t-c codec specifies the output codec"
  printf "\n\t-I indicates add the captured file to Apple Music"
  printf "\n\t-p preset specifies the ffmpeg preset to use"
  printf "\n\t\t Useful presets:"
  printf "\n\t\t ultrafast superfast veryfast faster fast medium slow"
  printf "\n\t\t slower veryslow. Default preset is 'slow'"
  printf "\n\t-q scale specifies the qscale variable bit rate quality"
  printf "\n\t-r rate specifies the rate for Constant Rate Factor (CRF)"
  printf "\n\t\tencoding. Use \"-r 0\" to disable for formats other than x264"
  printf "\n\t-b bitrate specifies the bitrate (default 128k)"
  printf "\n\t-t threads specifies the number of threads to use"
  printf "\n\t-y indicates overwrite output files without asking"
  printf "\n\t-u displays this usage message\n"
  printf "\nCurrent invocation defaults to:\n\n${FFMPEG} ${CAP} ${OPTS} ${OUT_FILE}\n"
  printf "\nExamples:"
  printf "\n\tThe most common use is capture using the default parameters"
  printf "\n\t\t$ME"
  printf "\n\tSpecify output video size of 640 width by 480 height"
  printf "\n\t\t$ME -s 640x480"
  printf "\n\tSpecify libx264 output video codec and use ipod640 preset"
  printf "\n\t\t$ME -v libx264 -p ipod640"
  printf "\n\tSpecify 512k bitrate and add capture file to Apple Music"
  printf "\n\t\t$ME -b 512k -I"
  printf "\n\tSpecify libx264 output video codec and variable bit rate"
  printf "\n\t\t$ME -v libx264 -r 0 -q 3\n"
  exit 1
}

while getopts A:V:o:O:p:q:r:b:t:s:v:z:a:c:IydCDu flag; do
    case $flag in
        A)
            AUDIO="$OPTARG"
            prompt_audio=
            ;;
        V)
            VIDEO="$OPTARG"
            prompt_video=
            ;;
        a)
            ACODEC="-acodec $OPTARG"
            ;;
        b)
            ASAMPLE="-ab $OPTARG"
            ;;
        o)
            SUF=$OPTARG
            DIR=`echo $SUF | tr '[:lower:]' '[:upper:]'`
            ;;
        O)
            OUT_PRE=$OPTARG
            ;;
        z)
            VSAMPLE="-vb $OPTARG"
            ;;
        c)
            CODEC="-codec $OPTARG"
            ;;
        C)
            CHARACTER=1
            ;;
        d)
            TELL=1
            ;;
        D)
            prompt_audio=
            prompt_video=
            ;;
        I)
            ITUNES=1
            ;;
        p)
            PRESET="-preset $OPTARG"
            ;;
        q)
            QSCALE="-qscale $OPTARG"
            RATE=
            ;;
        r)
            if [ $OPTARG -eq 0 ]
            then
                RATE=
            else
                RATE="-crf $OPTARG"
            fi
            ;;
        s)
            SIZE="-s $OPTARG"
            ;;
        t)
            THREAD="-threads $OPTARG"
            ;;
        y)
            OVER="-y"
            ;;
        v)
            VCODEC="-vcodec $OPTARG"
            ;;
        u)
            USAGE=1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

inst=`type -p osascript`
[ "$inst" ] && APPLE_SCRIPT=1
[ "$CHARACTER" ] && APPLE_SCRIPT=
if ([ "$APPLE_SCRIPT" ] && [ "$ITUNES" ])
then
    echo "Capture will automatically be imported into Apple Music"
else
    if [ "$ITUNES" ]
    then
        echo "AppleScript is not supported on this platform."
        echo "Unable to automate the installation in Apple Music."
        ITUNES=
    fi
fi
OUT_DIR=$HOME/Movies/ScreenCaps/$DIR
[ -d "${OUT_DIR}" ] || mkdir -p "${OUT_DIR}"
[ "${OUT_PRE}" ] || OUT_PRE="capture_$$"
OUT_FILE=${OUT_DIR}/${OUT_PRE}.$SUF
[ "$USAGE" ] || {
    [ "$prompt_audio" ] && GetAudioNum
    [ "$prompt_video" ] && GetVideoNum
}
[ "$AUDIO" ] || {
    AUDIO=`echo ${default_audio_number} | sed -e "s/\[//" -e "s/\]//"`
}
[ "$VIDEO" ] || {
    VIDEO=`echo ${default_video_number} | sed -e "s/\[//" -e "s/\]//"`
}
# Set ffmpeg capture options based upon the desired output format
LOG="-loglevel warning"
# RAT="-framerate 30"
RAT=
EXP="-strict -2"
# PIX="-pix_fmt yuv420p"
PIX=
VSY="-vsync 2"
#
# Set any options specified on the command line - the sed part is just
# removing any leading or trailing spaces.
OPTS=`echo "$OVER $ACODEC $CODEC $SIZE $VCODEC $PRESET $QSCALE $RATE $ASAMPLE $VSAMPLE $THREAD" | sed -e 's/^ *//' -e 's/ *$//'`
CAP="-f avfoundation -i $VIDEO:$AUDIO ${PIX} ${RAT} ${LOG} ${EXP} ${VSY}"
# Check for incompatible ffmpeg arguments
[ "$RATE" ] && [ "$QSCALE" ] && {
    printf "\nCannot specify both constant and variable bit rate values."
    printf "\nCurrent invocation would invoke:\n\n${FFMPEG} ${CAP} ${OPTS} ${OUT_FILE}\n"
    printf "\nExiting.\n"
    exit 1
}

# Display usage message and exit if -u was given on the command line.
# We delay until now in order to gather up all the other command line options.
[ "$USAGE" ] && usage

printf "\n${FFMPEG} ${CAP} ${OPTS} ${OUT_FILE}\n"
[ "$TELL" ] || {
    ${FFMPEG} ${CAP} ${OPTS} ${OUT_FILE}

    [ "$ITUNES" ] && {
        # Construct full pathname of output file
        k=`pwd`/"$j"
        echo "Adding $j to Apple Music"
        osascript -e "tell application \"Music\" to add POSIX file \"$k\""
    }
}
