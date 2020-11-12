#!/bin/bash

DIR="Wallhaven-Downloader"
[ -d $DIR ] && mv $DIR ${DIR}-
git clone https://github.com/macearl/Wallhaven-Downloader.git
