#!/bin/bash

[ -d Request_App ] && {
    rm -rf Request_App
}

git clone https://github.com/RequestNetwork/Request_App.git
