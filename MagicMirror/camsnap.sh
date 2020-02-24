#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
OUTD="$HOME/Pictures/Webcam"

[ -d "${OUTD}" ] || mkdir -p "${OUTD}"

fswebcam -r 1280x720 --no-banner "${OUTD}/${DATE}".jpg
