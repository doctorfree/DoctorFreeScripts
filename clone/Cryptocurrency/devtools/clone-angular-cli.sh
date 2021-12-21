#!/bin/bash

[ -d angular-cli ] && {
    sudo rm -rf angular-cli
}

git clone https://github.com/angular/angular-cli.git
