#!/bin/bash
#
## @file chrome-themes/Icons/mkpromo.sh
## @brief Create promotional images for use in Chrome theme store
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-May-2016
## @version 1.0.1
##

SIZE="320x320"
PRO1="440x280"
PRO2="920x680"

convert -size $SIZE canvas:none -font Bookman-DemiItalic -pointsize 30 \
        -draw "text 68,40 Doctorfree's" -channel RGBA -blur 0x6 -fill darkred \
        -stroke magenta -draw "text 65,37 Doctorfree's" icontop.png

convert -size $SIZE canvas:none -font Bookman-DemiItalic -pointsize 30 \
  -draw 'text 25,300 "Fractal Funhouse"' -channel RGBA -blur 0x6 -fill darkred \
  -stroke magenta -draw 'text 22,297 "Fractal Funhouse"' iconbot.png

convert -size $SIZE -composite iconbot.png icontop.png -geometry ${SIZE}+0+0 \
        -depth 8 text320.png

convert -size ${PRO1} -gravity center -composite Orig/Hyperbolic_Honeycomb.png \
        text320.png -geometry ${PRO1}\! -depth 8 Promotional_${PRO1}.png

convert -size ${PRO2} -gravity center -composite Orig/Hyperbolic_Honeycomb.png \
        text320.png -geometry ${PRO2}\! -depth 8 Promotional_${PRO2}.png

rm -f icontop.png iconbot.png text320.png
