#!/bin/bash
#
USER=doctorwhen
HOST=10.0.1.51
BDIR=$HOME/Seagate_8TB/Raspberry_Pi/Backups

duplicity --exclude-filelist=$HOME/duplicity_exclude.txt \
          --no-encryption \
          $HOME file://${BDIR}/Home
