#!/bin/bash

# Change this to the name of the Github project
tool="ARKit-Sampler"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

# Change this to the appropriate URL
git clone https://github.com/shu223/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
