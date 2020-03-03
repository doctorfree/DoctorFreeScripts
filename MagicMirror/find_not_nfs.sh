#!/bin/bash
#
# An example of how to prune specified directories from a find command
#

cd ${HOME}
find . -type d \( -path ./Seagate_8TB -o -path ./WD_My_Passport_4TB \) -prune \
    -o -type f -print0 | \
    xargs -0 grep -l Hello-Lucy | \
    grep -v /modules/Hello-Lucy/
