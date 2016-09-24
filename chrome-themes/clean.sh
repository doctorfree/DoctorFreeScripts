#!/bin/bash

[ -d Dist ] || mkdir Dist
for i in *.crx *.zip
do
    [ "$i" = "*.crx" ] && continue
    [ "$i" = "*.zip" ] && continue
    mv "$i" Dist
done
[ -d Keys ] || mkdir Keys
for i in *.pem
do
    [ "$i" = "*.pem" ] && continue
    mv "$i" Keys
done
mktheme -a -r
mktheme -a -r -s -b Seamless
