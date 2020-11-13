#!/bin/bash
#
## @file eject.sh
## @brief Eject the CD/DVD
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 28-Nov-2014
## @version 1.0.1
##
# Edit these to match the desired drive/model (strings returned by drutil list)
DRIVE="DVDRW"
MODEL="GX50N"

NUM=`drutil list | grep ${DRIVE} | grep ${MODEL} | awk ' { print $1 } '`
drutil tray eject ${NUM}
