#!/bin/bash

[ -d uport-registry ] && {
    rm -rf uport-registry
}

git clone https://github.com/uport-project/uport-registry.git
