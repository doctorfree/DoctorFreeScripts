#!/bin/bash

project="ffmpeg"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://git.ffmpeg.org/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
