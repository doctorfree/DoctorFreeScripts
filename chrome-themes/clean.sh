#!/bin/bash
#
## @file chrome-themes/clean.sh
## @brief Move created themes to Dist and invoke mktheme the cleanup
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 17-Feb-2016
## @version 1.0.1
##

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
