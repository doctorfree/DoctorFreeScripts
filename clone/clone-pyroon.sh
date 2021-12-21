#!/bin/bash

project="pyroon"
patch="$HOME/src/RoonCommandLine/patches/pyroon-listmedia.patch"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/pavoni/${project}.git

# [ -r ${patch} ] && {
#     patch -b -p0 < ${patch}
# }
