#!/bin/bash
#
## @file stop_leapd.sh
## @brief Convenience script to stop the Leap Motion daemon and agent
## @remark Moves the auto-start function to disable startup on system startup
## @remark Note this is OS X specific
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 12-Apr-2014
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
## Use in conjunctin with the Bash functions start-leap() and stop-leap()
## to replace automatic startup with manual startup/shutdown :
##
## Add these two functions to your .bashrc and you will then be able to start
## and stop the Leap Motion daemon and agent simply by typing "start-leap" and
## "stop-leap" at the Bash shell prompt.
##
## function start-leap() {
##     RUNNING=`ps -ef | grep "Leap Motion" | grep leapd`
##     [ "$RUNNING" ] || {
##        /Applications/Leap\ Motion.app/Contents/MacOS/leapd > /dev/null 2>&1 &
##        sleep 1
##     }
##     RUNNING=`ps -ef | grep "Leap Motion" | grep -v leapd | grep -v grep`
##     [ "$RUNNING" ] || {
##         open /Applications/Leap\ Motion.app
##     }
## }
## function stop-leap() {
##     RUNNING=`ps -ef | grep "Leap Motion" | grep leapd`
##     [ "$RUNNING" ] && killall leapd
##     RUNNING=`ps -ef | grep "Leap Motion" | grep -v leapd | grep -v grep`
##     [ "$RUNNING" ] && killall Leap\ Motion
## }
##
#
# The Launch scripts (use relative paths for tar's sake)
LEAPD="Library/LaunchDaemons/com.leapmotion.leapd.plist"
MOTION="Library/LaunchAgents/com.leapmotion.Leap-Motion.plist"

# Stop the currently running leapd daemon instance
RUNNING=`ps -ef | grep "Leap Motion" | grep leapd`
[ "$RUNNING" ] && sudo launchctl unload "/$LEAPD"

# Kill the Leap Motion application
RUNNING=`ps -ef | grep "Leap Motion" | grep -v grep`
[ "$RUNNING" ] && sudo killall Leap\ Motion

# Backup and remove the LaunchAgent script that starts the Leap Motion.app
# and the LaunchDaemon script that starts the leapd daemon on startup
cd /
[ -f "$LEAPD" ] && [ -f "$MOTION" ] && {
    tar cf - "$LEAPD" "$MOTION" | gzip -9 > $HOME/LeapMotionDaemonStart.tar.gz
    sudo rm -f "$LEAPD" "$MOTION"
}
