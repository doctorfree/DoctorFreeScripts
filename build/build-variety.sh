#!/bin/bash

[ -d variety ] || ./clone-variety.sh

cd variety
python3 setup.py install --prefix $HOME/.local
