#!/bin/bash
#
## @file updsums.sh
## @brief Create/update SUMS file containing chksums for all files in directory
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 7-July-2013
## @version 1.0.1
##
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

W="`pwd`"
SUMS="$W/SUMS.txt"
TELLME=
FORCE=

[ "$1" = "-d" ] && TELLME=1
[ "$1" = "-f" ] && FORCE=1

[ -r "$SUMS" ] || {
    echo "$SUMS does not exist."
    echo "Creating - this may take a few minutes ..."
    if [ "$TELLME" ]
    then
        find . -type f | while read i
        do
            echo "cksum $i"
        done
    else
        rm -f /tmp/sums$$
        touch /tmp/sums$$
        find . -type f | while read i
        do
            cksum "$i" >> /tmp/sums$$
        done
        sort /tmp/sums$$ > "$SUMS"
        rm -f /tmp/sums$$
    fi
    echo "Done."
    exit 0
}

# Remove entries in SUMS no longer in the tree
while read f
do
    fnam=`echo "$f" | awk ' { for(i=3;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
    [ -f "$fnam" ] || {
        # Backslash the brackets in any filenames so grep doesn't choke
        fixed=`echo "$f" | sed -e "s/\[/\\\\\[/g" -e "s/\]/\\\\\]/g"`
        if [ "$TELLME" ]
        then
            echo "grep -v $f $SUMS"
        else
            grep -v "$fixed" "$SUMS" > /tmp/sums$$
            cp /tmp/sums$$ "$SUMS"
            rm -f /tmp/sums$$
        fi
    }
done < "$SUMS"

# See if anything is new
if [ "$FORCE" ]
then
    newer=10
else
    newer=`find . \( -type f -or -type d \) -newer "$SUMS" | wc -l`
fi
if [ $newer -lt 2 ]
then
    echo "$SUMS is current"
else
    # Add new files
    find . -type f | while read f
    do
        fixed=`echo "$f" | sed -e "s/\[/\\\\\[/g" -e "s/\]/\\\\\]/g"`
        grep "$fixed" "$SUMS" > /dev/null || {
            if [ "$TELLME" ]
            then
                echo "cksum $f"
            else
                cksum "$f" >> "$SUMS"
            fi
        }
    done
fi
