#!/bin/bash

project="ubqminer"

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone https://github.com/ubiq/${project}.git
cd ${project}
git submodule update --init --recursive
