#!/bin/bash

[ -d colonySale ] && {
    rm -rf colonySale
}

git clone https://github.com/JoinColony/colonySale.git
