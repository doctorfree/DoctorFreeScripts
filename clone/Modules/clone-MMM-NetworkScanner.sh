#!/bin/bash

project="MMM-NetworkScanner"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/spitzlbergerj/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
