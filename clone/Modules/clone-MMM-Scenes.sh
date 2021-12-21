#!/bin/bash

project="MMM-Scenes"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/MMRIZE/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
