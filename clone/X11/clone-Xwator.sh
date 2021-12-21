#!/bin/bash

project="XWator"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone ssh://gitlab.com/doctorfree/XWator.git

[ -r ${patch} ] && tar xzvf ${patch}
