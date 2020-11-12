#!/bin/bash

project="$1"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone ssh://gitlab.com/doctorfree/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
