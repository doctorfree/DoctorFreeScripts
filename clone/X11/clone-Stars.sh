#!/bin/bash

project="Stars"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone ssh://gitlab.com/doctorfree/Stars.git

[ -r ${patch} ] && tar xzvf ${patch}
