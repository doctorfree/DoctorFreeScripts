#!/bin/bash

[ -d Nexus ] && {
    rm -rf Nexus
}

git clone https://github.com/Nexusoft/Nexus.git
