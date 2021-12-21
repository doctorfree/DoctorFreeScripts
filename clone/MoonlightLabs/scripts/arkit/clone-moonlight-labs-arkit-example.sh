#!/bin/bash

# Change this to the name of the Github project
tool="moonlight-labs-arkit-example"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

# Change this to the appropriate URL
git clone https://gitlab.com/moonlightlabs/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
