#!/bin/bash
#
# Join 2 or 3 images then split the resulting composite in half
#
# Copyright (c) 2014, Ronald Joe Record
# All rights reserved.
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

for dir in *
do
    [ -d "$dir" ] || continue
    [ -f "$dir"/Left.jpg ] || continue
    cd $dir
    MIDDLE=
    [ -f Middle.jpg ] && MIDDLE=Middle.jpg
    montage -border 0x0+0+0 -geometry 768x1024! Right.jpg $MIDDLE Left.jpg ../temp-$dir.jpg   
    convert -geometry 2048x768! ../temp-$dir.jpg ../temp3-$dir.jpg
    cd ..
    convert temp3-$dir.jpg -crop 50%x100% +repage comp3-$dir-%d.jpg
    mv comp3-$dir-0.jpg comp3-$dir-Left.jpg
    mv comp3-$dir-1.jpg comp3-$dir-Right.jpg
    rm temp3-$dir.jpg
    rm temp-$dir.jpg
done
