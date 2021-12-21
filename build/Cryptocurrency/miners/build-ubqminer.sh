#!/bin/bash

project="ubqminer"
TOP="$HOME/src/Cryptocurrency/miners"

[ -d "$TOP" ] || {
    echo "$TOP does not exist or is not a directory. Exiting."
    exit 1
}

cd "$TOP"
[ -d ubqminer ] || {
    [ -x ./clone-ubqminer.sh ] || {
        echo "$TOP/clone-ubqminer.sh does not exist or is not executable. Exiting."
        exit 2
    }
    ./clone-ubqminer.sh
}
cd ubqminer
sudo rm -rf build
mkdir build
cd build
#cmake ..
cmake .. -DETHASHCUDA=OFF -DETHASHCL=ON
cmake --build .
[ "$1" == "-i" ] && sudo make install
