#!/bin/bash

[ -d CDMS ] && {
    rm -rf CDMS
}

git clone https://github.com/vivosmith/CDMS.git
