#!/bin/bash

# Change this to the name of the Github project
tool="NextLevel"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

# Change this to the appropriate URL
git clone https://github.com/NextLevel/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
