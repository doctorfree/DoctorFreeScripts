#!/bin/bash

project="synergy-core"

[ -d ${project} ] && {
    rm -rf ${project}
}

# git clone https://github.com/symless/synergy-core.git
gh repo clone symless/${project}
