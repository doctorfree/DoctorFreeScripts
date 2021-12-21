#!/bin/bash

# Change this to the name of the Github project
tool="iOS-11-by-Examples"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

# Change this to the appropriate URL
git clone https://github.com/artemnovichkov/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
