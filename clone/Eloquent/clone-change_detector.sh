#!/bin/bash

project="change_detector"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone ssh://gitlab.ecld.io/eloquent/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
