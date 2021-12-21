#!/bin/bash

TOP="$HOME/src/Cryptocurrency/miners"

[ -d "$TOP" ] || {
    echo "$TOP does not exist or is not a directory. Exiting."
    exit 1
}

cd "$TOP"
[ -d ethminer ] || {
    [ -x ./clone-ethminer.sh ] || {
        echo "$TOP/clone-ethminer.sh does not exist or is not executable. Exiting."
        exit 2
    }
    ./clone-ethminer.sh
}
cd ethminer
sudo rm -rf build
mkdir build
cd build
#cmake ..
cmake .. -DETHASHCUDA=OFF -DETHASHCL=ON
cmake --build .
[ "$1" == "-i" ] && sudo make install
