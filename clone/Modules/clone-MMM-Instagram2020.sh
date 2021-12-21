#!/bin/bash

project="MMM-Instagram2020"
patch="${project}-patch.tgz"

[ -d ${project} ] && {
    rm -rf ${project}
}

git clone https://github.com/AlexanderSalter/${project}.git

[ -r ${patch} ] && tar xzvf ${patch}
