#!/bin/bash

BG=`get-background | awk -F "=" ' { print $2 } '`
BG_NAM=`basename ${BG}`

NUM=`echo ${BG_NAM} | sed -e "s/wallhaven-//" -e "s/femjoy_//" -e "s/x-art-//" -e "s/\.jpg//" -e "s/\.png//"`

[ "${NUM}" ] && linkit ${NUM}
