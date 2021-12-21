#!/bin/bash

project="DoctorFreeScripts"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

# git clone --recurse-submodules ssh://gitlab.com/doctorfree/Scripts.git
git clone ssh://gitlab.com/doctorfree/DoctorFreeScripts.git

[ -r ${patch} ] && tar xzvf ${patch}
