#!/bin/bash

project="codeSTACKr"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/${project}/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
