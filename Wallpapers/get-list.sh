#!/bin/bash
#
## @file Wallpapers/get-list.sh
## @brief Retrieve Wallhaven wallpapers using specified list of search terms
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 1-Oct-2016
## @version 1.0.1
##
## Usage: get-list /path/to/filename subdir

list="$1"
[ -r "$list" ] || {
    echo "List of search terms, $list not found. Exiting."
    exit 1
}
subdir="$2"
[ "$subdir" ] || {
    echo "Download dir not specified. Exiting."
    exit 1
}

cat "$list" | while read query
do
    ./get-search -l "$subdir" -p 1 -q "$query"
done
