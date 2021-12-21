#!/bin/bash

project="MMM-YouTubeWebView"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://gitlab.com/doctorfree/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
