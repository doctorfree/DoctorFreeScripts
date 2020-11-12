#!/bin/bash

project="smartboard"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/hangorazvan/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
