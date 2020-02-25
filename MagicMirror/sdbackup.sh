#!/bin/bash

NUMBACK="00"
OUT_DIR="/Volumes/Seagate_8TB/Raspberry_Pi/Backups"
OUT_FILE="Raspbian-MagicMirror-${NUMBACK}.iso"
DEVICE="/dev/rdisk3"

sudo dd if=${DEVICE} | gzip -9 > ${OUT_DIR}/${OUT_FILE}.gz
