#!/bin/bash

[ -d profit-trailer ] && {
    rm -rf profit-trailer
}

git clone https://github.com/taniman/profit-trailer.git
