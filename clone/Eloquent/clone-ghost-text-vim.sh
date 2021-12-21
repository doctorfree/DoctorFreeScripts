#!/bin/bash

project="ghost-text-vim"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/falstro/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
