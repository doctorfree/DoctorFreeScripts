#!/bin/bash

go get -d github.com/libp2p/go-libp2p/...
cd $HOME/go/src/github.com/libp2p/go-libp2p
make
make deps
