#!/bin/bash

project="foogallery"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/fooplugins/foogallery.git

[ -r ${patch} ] && tar xzvf ${patch}
