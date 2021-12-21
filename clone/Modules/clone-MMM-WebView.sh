#!/bin/bash

project="MMM-WebView"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/Iketaki/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
