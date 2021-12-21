#!/bin/bash

cmake -B./build -H. -DCMAKE_BUILD_TYPE=Release
cmake --build ./build -- install
