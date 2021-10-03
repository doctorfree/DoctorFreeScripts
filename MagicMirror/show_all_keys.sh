#!/bin/bash

CONFDIR="$HOME/src/Scripts/MagicMirror/config"

cd "${CONFDIR}"
echo "Showing keys in $CONFDIR"
../show_keys.sh
for i in Artists JAV Models Photographers Templates
do
    [ -d $i ] && {
        cd $i
        echo "Showing keys in $i"
        ../../show_keys.sh
        cd ..
    }
done
