#!/bin/bash

cd $HOME/src/miners/cpp-ethereum
cmake -DBUNDLE=miner
make
#sudo make install
