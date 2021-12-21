#!/bin/bash

project="Scripts"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone --recurse-submodules https://gitlab.com/doctorfree/Scripts.git

[ -r ${patch} ] && tar xzvf ${patch}
