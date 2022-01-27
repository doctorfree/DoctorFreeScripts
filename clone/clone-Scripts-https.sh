#!/bin/bash

project="DoctorFreeScripts"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone --recurse-submodules https://gitlab.com/doctorfree/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
