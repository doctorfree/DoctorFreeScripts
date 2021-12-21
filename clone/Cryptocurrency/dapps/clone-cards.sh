#!/bin/bash

[ -d cards ] && {
    rm -rf cards
}

git clone https://github.com/bcwoo/cards.git
