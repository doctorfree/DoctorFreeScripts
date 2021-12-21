#!/bin/bash

project="MirrorCommandLine.wiki"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://gitlab.com/doctorfree/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
