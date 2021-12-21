#!/bin/bash

project="MMM-YouTube"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/Anonym-tsk/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
