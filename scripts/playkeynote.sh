#!/bin/bash
#
# playkeynote - shell script to front-end playing a Keynote presentation
#               in user's Keynote iCloud folder
#
# Usage: playkeynote [-l] <presentation name>

KDIR="$HOME/Library/Mobile Documents/com~apple~Keynote/Documents"
KNAM="$1"

[ -d "$KDIR" ] || {
    echo "Keynote iCloud folder does not exist or is not a directory. Exiting."
    exit 1
}

if [ "$KNAM" == "-l" ]
then
    for key in "$KDIR"/"$2"*.key
    do
        [ "$key" == "$KDIR/$2*.key" ] && continue
        kname=`basename "$key" | sed -e "s/\.key//"`
        echo "$kname"
    done
else
    first=
    for key in "$KDIR"/"$KNAM"*.key
    do
        [ "$key" == "$KDIR/$KNAM*.key" ] && continue
        kname=`basename "$key"`
        if [ "$first" ]
        then
            echo "Keynote presentation already running. Cannot open multiple."
            echo "Skipping $kname"
        else
            echo "Opening \"$kname\""
            open "$key"
            first=1
        fi
    done
fi
