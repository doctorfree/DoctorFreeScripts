#!/bin/bash

PT_DIR="/usr/local/lib/ProfitTrailer"

[ -d ${PT_DIR} ] || {
    echo "${PT_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd ${PT_DIR}
pm2 stop blacklist
