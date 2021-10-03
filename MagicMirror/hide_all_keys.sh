#!/bin/bash

CONFDIR="$HOME/src/Scripts/MagicMirror/config"

cd "${CONFDIR}"
echo "Hiding keys in $CONFDIR"
../hide_keys.sh
for i in Artists JAV Models Photographers Templates
do
    [ -d $i ] && {
        cd $i
        echo "Hiding keys in $i"
        ../../hide_keys.sh
        cd ..
    }
done
