#!/bin/bash
#
BDIR=$HOME/Seagate_8TB/Raspberry_Pi/Backups

duplicity --exclude-filelist=$HOME/duplicity_exclude.txt \
          --no-encryption \
          verify \
          file://${BDIR}/Home $HOME
