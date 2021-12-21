#!/bin/bash

project="AdminLTE"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/ColorlibHQ/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
