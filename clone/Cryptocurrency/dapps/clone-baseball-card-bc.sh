#!/bin/bash

[ -d baseball-card-bc ] && {
    rm -rf baseball-card-bc
}

git clone https://github.com/spencewine/baseball-card-bc.git
