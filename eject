#!/bin/bash
#
# eject - Eject the CD/DVD
#
# Written 28-Nov-2014 by Ronald Joe Record <rr@ronrecord.com>
#
# Edit these to match the desired drive/model (strings returned by drutil list)
DRIVE="DVDRW"
MODEL="GX50N"

NUM=`drutil list | grep ${DRIVE} | grep ${MODEL} | awk ' { print $1 } '`
drutil tray eject ${NUM}
