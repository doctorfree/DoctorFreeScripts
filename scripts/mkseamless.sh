#!/bin/bash
#
## @file mkseamless.sh
## @brief Make a texture seamless
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date
## @version 1.0.1
##
## The Vertical.png image is available at
## https://gitlab.com/doctorfree/Scripts/blob/master/Vertical.png
##
## Usage: mkseamless filename [filename ...]
##
## Places the output seamless texture(s) in a subdirectory "Seamless"
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

# Where are the horizontal and vertical region files located ?
L=/usr/local/lib

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    echo "Usage: mkseamless filename [filename ...]"
    exit 1
}

[ "$1" ] || {
    usage
}

[ -r $L/Vertical.png ] || {
    echo "Missing file $L/Vertical.png"
    exit 2
}
cp $L/Vertical.png Vertical.png

[ -r Horizontal.png ] || {
    convert Vertical.png -rotate 90 Horizontal.png
}

[ -d Seamless ] || mkdir Seamless

for img in $*
do
    [ "$img" = "Thumbs.db" ] && continue
    [ -d $img ] && continue
    echo "Starting image tile for $img, this may take a short while ..."
    size=`identify -format '%G' "$img"`
    img_out=`echo $img | sed -e "s/\.jpg//" -e "s/\.JPG//" -e "s/\.png//" -e "s/\.gif//" -e "s/\.GIF//" -e "s/\.svg//"`
    convert $img -resize 1024x1024! tmp1.png
    montage tmp1.png tmp1.png tmp1.png tmp1.png -geometry +0+0 tmp2.png
    composite -compose CopyOpacity Vertical.png tmp1.png vert.png
    composite -compose CopyOpacity Horizontal.png tmp1.png horz.png
    composite -geometry +512+512 vert.png tmp2.png tmp2.png
    composite -geometry +512+512 horz.png tmp2.png tmp2.png
    convert -extent 1024x1024+512+512 tmp2.png tmp2.png
    montage tmp2.png tmp2.png tmp2.png tmp2.png -geometry +0+0 tmp2.png
    convert -extent 1024x1024+512+512 tmp2.png tmp2.png

    convert tmp2.png -resize $size! Seamless/${img_out}.png

    echo "Seamless/${img_out}.png created. Cleaning up."
    rm -f tmp1.png
    rm -f tmp2.png
    rm -f horz.png
    rm -f vert.png
done
rm -f Vertical.png Horizontal.png
echo "All Done !"
