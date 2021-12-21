#!/bin/bash

project="icheck"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/fronteed/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
