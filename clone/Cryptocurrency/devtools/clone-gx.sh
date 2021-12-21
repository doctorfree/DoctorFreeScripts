#!/bin/bash

[ -d gx ] && {
    sudo rm -rf gx
}

git clone https://github.com/whyrusleeping/gx.git
