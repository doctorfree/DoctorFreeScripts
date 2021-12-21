#!/bin/bash

autoreconf -i
sudo CFLAGS="-O2 -Wall -march=native -std=gnu99 -I/usr/include" LDFLAGS="-L/opt/amdgpu-pro/lib/x86_64-linux-gnu"  ./configure
sudo make
