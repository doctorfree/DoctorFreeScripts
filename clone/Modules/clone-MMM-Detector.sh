#!/bin/bash

project="MMM-Detector"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/bugsounet/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
