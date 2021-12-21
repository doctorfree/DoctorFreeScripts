#!/bin/bash

# Change this to the name of the Github project
tool="FaceRecognition-in-ARKit"

patch="${tool}-patch.tgz"

[ -d ${tool} ] && {
    rm -rf ${tool}
}

# Change this to the appropriate URL
git clone https://github.com/NovaTecConsulting/${tool}.git

[ -r ${patch} ] && tar xzvf ${patch}
