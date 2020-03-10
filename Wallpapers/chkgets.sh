#!/bin/bash

for i in get-*.sh
do
    j=`echo $i | sed -e "s/.sh//"`
    [ -f $HOME/bin/$j ] || {
        echo "No $HOME/bin/$j"
        continue
    }
    diff $i $HOME/bin/$j > /dev/null || echo "$i differs with $HOME/bin/$j"
done
