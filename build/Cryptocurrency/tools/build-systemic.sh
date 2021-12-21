#!/bin/bash

SDIR=Systemic2
[ -d "$SDIR" ] || ./clone-systemic.sh

cd "$SDIR"
make -f Makefile.linux
