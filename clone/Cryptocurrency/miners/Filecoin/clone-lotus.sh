#!/bin/bash

project="lotus"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/filecoin-project/${project}.git
#cd ${project}
#git submodule update --init --recursive
