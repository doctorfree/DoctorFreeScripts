#!/bin/bash
#
BDIR=$HOME/Seagate_8TB/Raspberry_Pi/Backups

duplicity --force --no-encryption \
          restore --restore-time 2020-02-22T16:06:42+08:00 \
          file://${BDIR}/Home $HOME
